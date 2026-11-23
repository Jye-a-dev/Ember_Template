import './windows-compat.mjs';
import { defineConfig, loadEnv, createLogger } from 'vite';
import { extensions, classicEmberSupport, ember } from '@embroider/vite';
import { babel } from '@rollup/plugin-babel';
import tailwindcss from '@tailwindcss/vite';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const customLogger = createLogger();
const originalWarn = customLogger.warn;
customLogger.warn = (msg, options) => {
  if (msg.includes('points to a source file outside its package')) {
    return;
  }
  originalWarn(msg, options);
};

export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), '');
  const port = parseInt(env.PORT || '5000', 10);

  return {
    customLogger,
    optimizeDeps: {
      exclude: ['tailwind-merge'],
    },
    server: {
      port,
      host: true,
    },
    preview: {
      port,
      host: true,
    },
    resolve: {
      alias: {
        '@': path.resolve(__dirname, './app'),
      },
    },
    plugins: [
      tailwindcss(),
      classicEmberSupport(),
      ember(),
      babel({
        babelHelpers: 'runtime',
        extensions,
      }),
    ],
  };
});
