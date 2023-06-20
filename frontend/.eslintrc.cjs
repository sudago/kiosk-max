module.exports = {
  env: {
    browser: true,
  },
  extends: ["airbnb", "plugin:@typescript-eslint/recommended", "prettier"],
  parser: "@typescript-eslint/parser",
  plugins: ["@typescript-eslint", "prettier"],
  rules: {
    "prettier/prettier": ["error"],
    "@typescript-eslint/no-non-null-assertion": "off",
    "react/jsx-filename-extension": ["warn", { extensions: [".tsx"] }],
  },
  root: true,
};
