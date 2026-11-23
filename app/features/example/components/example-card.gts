import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { service } from '@ember/service';
import { on } from '@ember/modifier';
import { fn } from '@ember/helper';
import Button from '@/components/ui/button';
import Input from '@/components/ui/input';
import { createTaskSchema } from '../schemas/example.schema';
import type ExampleService from '../services/example-service';

export default class ExampleCard extends Component {
  @service('example-service') declare exampleService: ExampleService;

  @tracked newTaskTitle = '';
  @tracked validationError: string | null = null;

  handleInput = (event: Event): void => {
    const target = event.target as HTMLInputElement;
    this.newTaskTitle = target.value;
    if (this.validationError) {
      this.validationError = null;
    }
  };

  handleSubmit = (event: Event): void => {
    event.preventDefault();
    const result = createTaskSchema.safeParse({ title: this.newTaskTitle });

    if (!result.success) {
      this.validationError =
        result.error.issues[0]?.message ?? 'Dữ liệu không hợp lệ';
      return;
    }

    this.exampleService.addTask(result.data.title);
    this.newTaskTitle = '';
    this.validationError = null;
  };

  handleToggle = (id: string): void => {
    this.exampleService.toggleTask(id);
  };

  handleDelete = (id: string): void => {
    this.exampleService.deleteTask(id);
  };

  <template>
    <div
      class="mx-auto w-full max-w-2xl overflow-hidden rounded-2xl border border-slate-200 bg-white shadow-xl dark:border-slate-800 dark:bg-slate-900"
    >
      <div
        class="border-b border-slate-200 bg-gradient-to-r from-blue-50/50 to-indigo-50/50 p-6 dark:border-slate-800 dark:from-slate-900 dark:to-slate-900"
      >
        <div class="flex items-center justify-between">
          <div>
            <h2 class="text-xl font-bold text-slate-900 dark:text-white">Feature
              Example: Quản lý Nhiệm vụ</h2>
            <p class="mt-1 text-sm text-slate-500 dark:text-slate-400">
              Minh họa Reactive State (@tracked) + Glimmer Template (.gts) + Zod
              Schema Validation
            </p>
          </div>
          <span
            class="rounded-full bg-blue-100 px-3 py-1 text-xs font-semibold text-blue-800 dark:bg-blue-900/40 dark:text-blue-300"
          >
            {{this.exampleService.tasks.length}}
            mục
          </span>
        </div>
      </div>

      <div class="space-y-6 p-6">
        <form
          {{on "submit" this.handleSubmit}}
          class="flex flex-col items-start gap-3 sm:flex-row"
        >
          <div class="w-full flex-1">
            <Input
              @id="task-title-input"
              @value={{this.newTaskTitle}}
              @placeholder="Nhập tiêu đề nhiệm vụ mới..."
              @error={{if this.validationError this.validationError undefined}}
              {{on "input" this.handleInput}}
            />
          </div>
          <Button @type="submit" @variant="primary">
            Thêm mới
          </Button>
        </form>

        {{#if this.exampleService.isLoading}}
          <div class="py-8 text-center text-sm text-slate-500">
            Đang tải danh sách nhiệm vụ...
          </div>
        {{else if this.exampleService.error}}
          <div
            class="rounded-lg border border-red-200 bg-red-50 p-4 text-sm text-red-700"
          >
            {{this.exampleService.error}}
          </div>
        {{else}}
          <ul class="divide-y divide-slate-100 dark:divide-slate-800">
            {{#each this.exampleService.tasks as |task|}}
              <li class="group flex items-center justify-between gap-4 py-3">
                <label class="flex flex-1 cursor-pointer items-center gap-3">
                  <input
                    type="checkbox"
                    checked={{task.completed}}
                    class="h-4 w-4 cursor-pointer rounded border-slate-300 text-blue-600 focus:ring-blue-500"
                    {{on "change" (fn this.handleToggle task.id)}}
                  />
                  <span
                    class="text-sm
                      {{if
                        task.completed
                        'text-slate-400 line-through dark:text-slate-500'
                        'text-slate-700 dark:text-slate-200'
                      }}"
                  >
                    {{task.title}}
                  </span>
                </label>
                <Button
                  @variant="outline"
                  @size="sm"
                  class="text-xs opacity-80 group-hover:opacity-100 hover:text-red-600 dark:hover:text-red-400"
                  {{on "click" (fn this.handleDelete task.id)}}
                >
                  Xóa
                </Button>
              </li>
            {{else}}
              <li class="py-8 text-center text-sm text-slate-400">
                Chưa có nhiệm vụ nào. Hãy thêm nhiệm vụ đầu tiên!
              </li>
            {{/each}}
          </ul>
        {{/if}}
      </div>
    </div>
  </template>
}
