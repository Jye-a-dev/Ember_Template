/* eslint-disable */
import path from 'node:path';
import fs from 'node:fs';
import { createRequire } from 'node:module';

const require = createRequire(import.meta.url);

if (process.platform === 'win32') {
  // Normalize drive letter casing in process.cwd() for Windows
  const cwd = process.cwd();
  if (/^[a-z]:/.test(cwd)) {
    try {
      process.chdir(cwd.charAt(0).toUpperCase() + cwd.slice(1));
    } catch {}
  }

  // Ensure Node 22.11.0 supports require() of ESM dependencies in ember-cli
  if (
    !process.env.NODE_OPTIONS ||
    !process.env.NODE_OPTIONS.includes('--experimental-require-module')
  ) {
    process.env.NODE_OPTIONS =
      (process.env.NODE_OPTIONS ? process.env.NODE_OPTIONS + ' ' : '') +
      '--experimental-require-module';
  }
  function patchFs(fsModule) {
    if (!fsModule || fsModule._patchedByEmberTemplate) return;
    fsModule._patchedByEmberTemplate = true;

    const origSymlinkSync = fsModule.symlinkSync;
    if (origSymlinkSync) {
      fsModule.symlinkSync = function (target, p, type) {
        try {
          return origSymlinkSync.call(fsModule, target, p, type);
        } catch (err) {
          if (err.code === 'EPERM' || err.code === 'EACCES') {
            const absTarget = path.resolve(path.dirname(p), target);
            const isDir =
              type === 'dir' ||
              type === 'junction' ||
              (!type &&
                fs.existsSync(absTarget) &&
                fs.statSync(absTarget).isDirectory());

            if (isDir) {
              try {
                return origSymlinkSync.call(fsModule, absTarget, p, 'junction');
              } catch {
                if (
                  fs.existsSync(absTarget) &&
                  fs.statSync(absTarget).isDirectory()
                ) {
                  fs.cpSync(absTarget, p, { recursive: true });
                  return;
                }
              }
            } else {
              // Target is a file: fallback to copyFileSync
              try {
                fs.mkdirSync(path.dirname(p), { recursive: true });
                return fs.copyFileSync(absTarget, p);
              } catch {
                throw err;
              }
            }
          }
          throw err;
        }
      };
    }

    let inUnlink = false;
    const origUnlinkSync = fsModule.unlinkSync;
    if (origUnlinkSync) {
      fsModule.unlinkSync = function (p) {
        try {
          return origUnlinkSync.call(fsModule, p);
        } catch (err) {
          if (
            !inUnlink &&
            (err.code === 'EPERM' || err.code === 'EISDIR') &&
            fs.existsSync(p) &&
            fs.statSync(p).isDirectory()
          ) {
            inUnlink = true;
            try {
              return fs.rmSync(p, { recursive: true, force: true });
            } finally {
              inUnlink = false;
            }
          }
          throw err;
        }
      };
    }

    let inRmdir = false;
    const origRmdirSync = fsModule.rmdirSync;
    if (origRmdirSync) {
      fsModule.rmdirSync = function (p, options) {
        try {
          return origRmdirSync.call(fsModule, p, options);
        } catch (err) {
          if (
            !inRmdir &&
            (err.code === 'ENOTEMPTY' || err.code === 'EPERM') &&
            fs.existsSync(p)
          ) {
            inRmdir = true;
            try {
              return fs.rmSync(p, { recursive: true, force: true });
            } finally {
              inRmdir = false;
            }
          }
          throw err;
        }
      };
    }
  }

  patchFs(fs);
  try {
    patchFs(require('node:fs'));
  } catch {}
  try {
    patchFs(require('graceful-fs'));
  } catch {}

  function patchFsExtra(baseDir) {
    try {
      const fsLibPath = require.resolve('fs-extra/lib/fs', {
        paths: [baseDir],
      });
      const fsExtraFs = require(fsLibPath);
      patchFs(fsExtraFs);
    } catch {}
    try {
      const fsExtraPath = require.resolve('fs-extra', { paths: [baseDir] });
      const fsExtra = require(fsExtraPath);
      patchFs(fsExtra);
    } catch {}
  }

  patchFsExtra(process.cwd());
  try {
    const evPath = require.resolve('@embroider/vite');
    patchFsExtra(path.dirname(evPath));
  } catch {}
}
