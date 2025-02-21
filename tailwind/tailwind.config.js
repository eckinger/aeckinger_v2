const plugin = require('tailwindcss/plugin');

module.exports = {
    theme: {
        extend: {
            colors: {
                'highlight': '#537D8D',
            },
            fontFamily: {
                'nothingyoucoulddo': ['Nothing You Could Do', 'cursive'],
                'signika': ['Signika', 'sans-serif'],
            },
        },
    },
    content: [
        "Web/View/**/*.hs",
    ],
    safelist: [
        // Add custom class names.
        //https://tailwindcss.com/docs/content-configuration#safelisting-classes
    ],
    plugins: [
        require('@tailwindcss/forms'),
    ],
};
