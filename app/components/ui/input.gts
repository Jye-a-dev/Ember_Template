import type { TOC } from '@ember/component/template-only';
import { cn } from '@/utils/cn';

export interface InputSignature {
  Element: HTMLInputElement;
  Args: {
    id?: string;
    label?: string;
    error?: string;
    value?: string;
    type?: string;
    placeholder?: string;
    disabled?: boolean;
  };
}

const Input: TOC<InputSignature> = <template>
  <div class="flex w-full flex-col gap-1.5">
    {{#if @label}}
      <label
        for={{@id}}
        class="text-sm font-medium text-slate-700 dark:text-slate-300"
      >
        {{@label}}
      </label>
    {{/if}}
    <input
      id={{@id}}
      type={{if @type @type "text"}}
      value={{@value}}
      disabled={{@disabled}}
      placeholder={{@placeholder}}
      class={{cn
        "flex h-9 w-full rounded-lg border border-slate-300 bg-white px-3 py-1 text-sm text-slate-900 shadow-sm transition-colors placeholder:text-slate-400 focus-visible:ring-2 focus-visible:ring-blue-500 focus-visible:outline-none disabled:cursor-not-allowed disabled:opacity-50 dark:border-slate-700 dark:bg-slate-900 dark:text-slate-100"
        (if @error "border-red-500 focus-visible:ring-red-500")
      }}
      ...attributes
    />
    {{#if @error}}
      <span class="text-xs text-red-500">{{@error}}</span>
    {{/if}}
  </div>
</template>;

export default Input;
