import { pageTitle } from 'ember-page-title';

<template>
  {{pageTitle "Ember Template"}}

  <div
    class="flex min-h-screen flex-col bg-slate-50 font-sans text-slate-900 antialiased dark:bg-slate-950 dark:text-slate-100"
  >
    <header
      class="sticky top-0 z-50 border-b border-slate-200 bg-white/80 backdrop-blur dark:border-slate-800 dark:bg-slate-900/80"
    >
      <div
        class="mx-auto flex h-16 max-w-7xl items-center justify-between px-4 sm:px-6 lg:px-8"
      >
        <div class="flex items-center gap-3">
          <div
            class="flex h-9 w-9 items-center justify-center rounded-xl bg-gradient-to-tr from-amber-500 to-rose-600 text-lg font-bold text-white shadow-sm"
          >
            E
          </div>
          <div>
            <h1
              class="text-base leading-tight font-semibold text-slate-900 dark:text-white"
            >Ember Template</h1>
            <p
              class="text-xs text-slate-500 dark:text-slate-400"
            >Production-Ready Architecture</p>
          </div>
        </div>
        <div class="flex items-center gap-3 text-sm">
          <span
            class="inline-flex items-center rounded-full border border-emerald-200 bg-emerald-100 px-2.5 py-0.5 text-xs font-medium text-emerald-800 dark:border-emerald-800 dark:bg-emerald-900/30 dark:text-emerald-400"
          >
            Port 5000 Active
          </span>
        </div>
      </div>
    </header>

    <main class="mx-auto w-full max-w-7xl flex-1 px-4 py-8 sm:px-6 lg:px-8">
      {{outlet}}
    </main>

    <footer
      class="border-t border-slate-200 bg-white py-6 text-center text-xs text-slate-500 dark:border-slate-800 dark:bg-slate-900 dark:text-slate-400"
    >
      Ember.js Modern Polaris • Vite • Tailwind CSS v4 • TypeScript & Glint •
      Zod
    </footer>
  </div>
</template>
