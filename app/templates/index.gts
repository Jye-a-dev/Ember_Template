import { pageTitle } from 'ember-page-title';
import ExampleCard from '@/features/example/components/example-card';

<template>
  {{pageTitle "Trang chủ"}}

  <div class="space-y-8">
    <div class="mx-auto max-w-2xl space-y-3 text-center">
      <h2
        class="text-3xl font-extrabold tracking-tight text-slate-900 sm:text-4xl dark:text-white"
      >
        Template Chuẩn Production-Ready
      </h2>
      <p class="text-base text-slate-600 dark:text-slate-400">
        Kiến trúc Thin Routes + Feature-Based Hybrid, tối ưu hóa cho làm việc
        độc lập (Solo) và phối hợp nhóm (Team).
      </p>
    </div>

    <ExampleCard />
  </div>
</template>
