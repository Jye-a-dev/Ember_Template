import Component from '@glimmer/component';
import { cn } from '@/utils/cn';

export interface ButtonSignature {
  Element: HTMLButtonElement;
  Args: {
    variant?: 'primary' | 'secondary' | 'outline' | 'danger';
    size?: 'sm' | 'md' | 'lg';
    type?: 'button' | 'submit' | 'reset';
    disabled?: boolean;
  };
  Blocks: {
    default: [];
  };
}

export default class Button extends Component<ButtonSignature> {
  get variantClass(): string {
    const variant = this.args.variant ?? 'primary';
    switch (variant) {
      case 'secondary':
        return 'bg-slate-700 text-white hover:bg-slate-600 focus-visible:ring-slate-500';
      case 'outline':
        return 'border border-slate-300 bg-transparent text-slate-800 hover:bg-slate-100 focus-visible:ring-slate-400 dark:border-slate-700 dark:text-slate-100 dark:hover:bg-slate-800';
      case 'danger':
        return 'bg-red-600 text-white hover:bg-red-500 focus-visible:ring-red-500';
      case 'primary':
      default:
        return 'bg-blue-600 text-white hover:bg-blue-500 focus-visible:ring-blue-500';
    }
  }

  get sizeClass(): string {
    const size = this.args.size ?? 'md';
    switch (size) {
      case 'sm':
        return 'h-8 px-3 text-xs';
      case 'lg':
        return 'h-11 px-6 text-base';
      case 'md':
      default:
        return 'h-9 px-4 text-sm';
    }
  }

  <template>
    <button
      type={{if @type @type "button"}}
      disabled={{@disabled}}
      class={{cn
        "inline-flex cursor-pointer items-center justify-center rounded-lg font-medium transition-colors focus-visible:ring-2 focus-visible:ring-offset-2 focus-visible:outline-none disabled:pointer-events-none disabled:opacity-50"
        this.variantClass
        this.sizeClass
      }}
      ...attributes
    >
      {{yield}}
    </button>
  </template>
}
