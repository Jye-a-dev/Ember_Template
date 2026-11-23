# Quy ước Kiến trúc & Phát triển Ember Modern (Production-Ready)

## 1. Thành phần Glimmer Component & GTS

- Bắt buộc dùng Glimmer Component (`@glimmer/component`) với cú pháp single-file `<template>` trong file `.gts`.
- Quản lý reactive state bằng decorator `@tracked` (`@glimmer/tracking`).
- Quản lý shared state qua singleton Ember Service (`@service` từ `@ember/service`).
- Tuyệt đối CẤM cú pháp Ember Classic: không dùng `EmberObject.extend`, `@computed`, `this.set()`, `this.get()`, mixins, hay file template `.hbs` tách rời.

## 2. Cấu trúc Thư mục & Nguyên tắc Phân chia (Thin Routes + Feature Modules)

- Giữ `app/routes/` và `app/templates/` cực mỏng: chỉ dùng cho routing, nạp dữ liệu ở `model()` và render component gốc.
- Đưa toàn bộ logic nghiệp vụ vào `app/features/<feature-name>/`:
  - `api/`: Các hàm gọi API riêng biệt cho feature.
  - `components/`: Glimmer components (`.gts`) chỉ dùng nội bộ trong feature.
  - `schemas/`: Zod validation schemas (`.schema.ts`).
  - `services/`: Ember Services quản lý reactive state của feature.
  - `types/`: Type definitions và interfaces riêng (`index.ts`).
- Component giao diện dùng chung toàn app đặt tại `app/components/ui/`.
- Utility functions đặt tại `app/utils/` (ví dụ `cn.ts` gộp class Tailwind).

## 3. Styling & Path Alias

- Bắt buộc sử dụng Tailwind CSS v4 với `@tailwindcss/vite` và `@import "tailwindcss";` trong `app/styles/app.css`.
- Sử dụng Path Alias `@/*` trỏ về `./app/*` cho mọi import nội bộ dự án.

## 4. Kiểm tra Môi trường & Type Safety

- Validate toàn bộ biến môi trường bằng Zod trong `app/config/env.ts`.
- Mọi template và component phải pass kiểm tra Glint / `ember-tsc --noEmit`.

## 5. Quy chuẩn Cam kết Code (Git & Commit)

- Bắt buộc tuân thủ Conventional Commits: `feat:`, `fix:`, `chore:`, `docs:`, `refactor:`, `style:`, `test:`.
- Toàn bộ commit tự động kiểm tra qua Husky (`lint-staged` và `commitlint`).
