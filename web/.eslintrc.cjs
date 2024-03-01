/** @type {import('eslint').Linter.Config} */
module.exports = {
  root: true,
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:svelte/recommended',
    'plugin:unicorn/recommended',
  ],
  parser: '@typescript-eslint/parser',
  plugins: ['@typescript-eslint'],
  parserOptions: {
    sourceType: 'module',
    ecmaVersion: 2022,
    extraFileExtensions: ['.svelte'],
    tsconfigRootDir: __dirname,
    project: ['./tsconfig.json'],
  },
  env: {
    browser: true,
    es2017: true,
    node: true,
  },
  overrides: [
    {
      files: ['*.svelte'],
      parser: 'svelte-eslint-parser',
      parserOptions: {
        parser: '@typescript-eslint/parser',
      },
    },
  ],
  globals: {
    NodeJS: true,
  },
  rules: {
    '@typescript-eslint/no-unused-vars': [
      'warn',
      {
        // Allow underscore (_) variables
        argsIgnorePattern: '^_$',
        varsIgnorePattern: '^_$',
      },
    ],
    curly: 2,
    'unicorn/no-useless-undefined': 'off',
    'unicorn/prefer-spread': 'off',
    'unicorn/no-null': 'off',
    'unicorn/prevent-abbreviations': 'off',
    'unicorn/no-nested-ternary': 'off',
    'unicorn/consistent-function-scoping': 'off',
    'unicorn/prefer-top-level-await': 'off',
    // TODO: set recommended-type-checked and remove these rules
    '@typescript-eslint/await-thenable': 'error',
    '@typescript-eslint/no-floating-promises': 'error',
    '@typescript-eslint/no-misused-promises': 'error',
    '@typescript-eslint/require-await': 'error',
  },
};
