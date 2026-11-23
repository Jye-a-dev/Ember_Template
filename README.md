# Ember.js Modern Polaris Template (Production-Ready)

Template khởi tạo dự án Ember.js hiện đại theo chuẩn kiến trúc Polaris, tối ưu cho cả làm việc độc lập (**Solo**) và phối hợp nhóm (**Team**). Dự án sử dụng Vite, Embroider, Glimmer Components (`.gts`), Tailwind CSS v4 và TypeScript strict mode.

---

## 🚀 Tech Stack

| Thư viện / Công cụ        | Phiên bản thực tế    | Mục đích                                                         |
| :------------------------ | :------------------- | :--------------------------------------------------------------- |
| **Ember Source**          | `~7.4.0`             | Core Framework (Polaris / Octane edition)                        |
| **@embroider/vite**       | `^1.8.0`             | Next-gen Vite build system cho Ember                             |
| **Vite**                  | `^8.3.8`             | Dev server tốc độ cao & Bundler                                  |
| **TypeScript**            | `^6.0.3`             | Ngôn ngữ tĩnh kiểu mạnh (hỗ trợ Path Mapping `@/*`)              |
| **@glint/ember-tsc**      | `^1.14.3`            | Type-check toàn diện cả `.ts` lẫn `<template>` trong `.gts`      |
| **Tailwind CSS**          | `^4.3.5`             | Utility-first CSS framework thế hệ mới                           |
| **@tailwindcss/vite**     | `^4.3.5`             | Vite plugin tích hợp trực tiếp cho Tailwind v4                   |
| **Zod**                   | `^4.6.7`             | Type-safe schema validation cho Form và Biến môi trường          |
| **clsx & tailwind-merge** | `^2.1.1` / `^3.7.1`  | Tiện ích gộp class Tailwind chống xung đột (`cn()`)              |
| **ESLint**                | `^9.39.5`            | Flat Config (`eslint.config.mjs`) tích hợp `eslint-plugin-ember` |
| **Ember Template Lint**   | `^7.9.4`             | Kiểm tra quy chuẩn & Accessibility cho template                  |
| **Prettier**              | `^3.10.1`            | Tự động format `.gts`, `<template>` và sắp xếp class Tailwind    |
| **Husky & Lint-Staged**   | `^9.1.7` / `^17.6.2` | Tự động chạy linter và type-check trước khi commit               |
| **Commitlint**            | `^21.2.4`            | Kiểm soát chuẩn Conventional Commits                             |

---

## 📋 Yêu cầu hệ thống

- **Node.js**: Phiên bản LTS `>= 20.19.0` (khuyến nghị Node `22.x` theo file `.nvmrc`).
- **NPM**: `>= 10.x`.
- **VS Code Extensions khuyến nghị** (tự động gợi ý qua `.vscode/extensions.json`):
  - `typed-ember.glint-vscode`: Hỗ trợ IntelliSense & Type-checking cho file `.gts`.
  - `emberjs.vscode-ember`: Hỗ trợ cú pháp Ember.
  - `dbaeumer.vscode-eslint`: Báo lỗi linter trực tiếp trong editor.
  - `esbenp.prettier-vscode`: Tự động format khi lưu file.
  - `bradlc.vscode-tailwindcss`: Gợi ý class Tailwind CSS.

---

## ⚡ Hướng dẫn Quick Start

Chỉ với 5 bước đơn giản để khởi chạy dự án:

```bash
# 1. Clone repository
git clone <repository-url> ember_template
cd ember_template

# 2. Tạo file cấu hình môi trường
cp .env.example .env

# 3. Cài đặt dependencies
npm install

# 4. Khởi chạy development server
npm run dev

# 5. Truy cập ứng dụng tại
# http://localhost:5000
```

---

## ⚙️ Biến môi trường (.env)

Hệ thống cấu hình cổng chạy mặc định là **5000** và được kiểm soát hoàn toàn qua file `.env` kết hợp Zod validation tại `app/config/env.ts`.

| Biến                | Giá trị mặc định            | Giải thích                                                                     |
| :------------------ | :-------------------------- | :----------------------------------------------------------------------------- |
| `PORT`              | `5000`                      | Cổng dev server và preview server lắng nghe (thay đổi giá trị này để đổi port) |
| `VITE_APP_URL`      | `http://localhost:5000`     | Địa chỉ URL gốc của ứng dụng frontend                                          |
| `VITE_API_BASE_URL` | `http://localhost:8000/api` | Địa chỉ base URL của backend API                                               |

---

## 📂 Sơ đồ Cấu trúc thư mục & Nguyên tắc phân chia

Dự án áp dụng mô hình kiến trúc **Thin Routes + Feature-Based Hybrid**:

```
app/
├── components/
│   └── ui/                     # UI Glimmer components tái sử dụng toàn app (button.gts, input.gts...)
├── config/
│   └── env.ts                  # Validate & export biến môi trường typed bằng Zod
├── features/                   # Chia theo module nghiệp vụ (mỗi người/team phụ trách 1 folder)
│   └── example/
│       ├── api/                # Hàm gọi API riêng của feature (example.api.ts)
│       ├── components/         # Glimmer components (.gts) chỉ dùng nội bộ trong feature
│       ├── schemas/            # Zod validation schemas (example.schema.ts)
│       ├── services/           # Ember Services (@tracked state) riêng của feature
│       └── types/              # TypeScript types/interfaces riêng của feature
├── routes/                     # CHỈ chứa Route handlers mỏng (application.ts, index.ts...)
├── services/                   # Global singleton Ember Services (api-client.ts, store.ts...)
├── styles/
│   └── app.css                 # @import "tailwindcss"; (Tailwind CSS v4)
├── templates/                  # CHỈ chứa entry template của route (.gts)
│   ├── application.gts         # Root layout gọn sạch với {{outlet}}
│   └── index.gts               # Entry template cho trang chủ
├── types/
│   └── api.ts                  # Global TypeScript interfaces/types
└── utils/
    └── cn.ts                   # Helper gộp class Tailwind (clsx + tailwind-merge)
```

### Nguyên tắc phân chia code:

1. **`app/routes/` & `app/templates/` (Thin Routes):** Tuyệt đối không chứa logic tính toán phức tạp. Route chỉ đảm nhận nạp dữ liệu ở `model()` và template chỉ render component gốc của feature.
2. **`app/features/<feature>/`:** Toàn bộ logic giao diện, form validation (Zod), local state (`@tracked`), và API fetch của một nghiệp vụ được gom chung vào folder feature tương ứng để tránh xung đột khi làm việc nhóm.
3. **`app/components/ui/`:** Nơi đặt các UI component cơ bản (Button, Input, Modal, Dropdown...) mang tính dùng chung trên toàn hệ thống.
4. **`app/services/`:** Quản lý shared state toàn cục (API client, Authentication, Theme...).

---

## 🛠️ Danh sách NPM Scripts

| Lệnh                 | Chức năng                                                                                       |
| :------------------- | :---------------------------------------------------------------------------------------------- |
| `npm run dev`        | Khởi chạy Vite development server tại cổng được cấu hình trong `.env` (`http://localhost:5000`) |
| `npm run build`      | Thực hiện build production tối ưu hóa mã nguồn                                                  |
| `npm run preview`    | Khởi chạy server preview bản build production                                                   |
| `npm run type-check` | Kiểm tra kiểu dữ liệu toàn diện (cả file `.ts` và khối `<template>` trong `.gts` qua Glint)     |
| `npm run lint`       | Chạy đồng thời ESLint, Ember Template Lint, Stylelint và kiểm tra Prettier                      |
| `npm run lint:fix`   | Tự động sửa các lỗi linting và định dạng code                                                   |
| `npm run format`     | Định dạng toàn bộ mã nguồn theo chuẩn Prettier                                                  |
| `npm test`           | Chạy kiểm thử tự động với QUnit và Testem                                                       |

---

## 📝 Quy ước Git Commit (Conventional Commits)

Dự án cài đặt sẵn Git Hooks thông qua **Husky** và **Commitlint**. Mọi commit message bắt buộc tuân theo định dạng:

```
<type>(<scope>): <mô tả ngắn gọn>
```

### Các tiền tố hợp lệ:

- `feat:` Thêm tính năng mới cho ứng dụng.
- `fix:` Sửa lỗi.
- `refactor:` Tái cấu trúc code nhưng không thay đổi chức năng.
- `chore:` Cập nhật cấu hình build, dependencies hoặc tooling.
- `docs:` Thêm hoặc sửa đổi tài liệu.
- `style:` Thay đổi định dạng, khoảng trắng, không ảnh hưởng logic.
- `test:` Thêm hoặc cập nhật unit/integration tests.
