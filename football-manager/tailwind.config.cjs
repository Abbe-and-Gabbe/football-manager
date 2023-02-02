/** @type {import('tailwindcss').Config} */
module.exports = {
    content: ["./src/**/*.{html,js,svelte,ts}"],
    theme: {
        extend: {
            animation: {
                // fade-in
                "fade-in": "fade-in .5s ease-in-out",
                "expand-in": "expand-in 2.5s ease-in-out",
                "expand-out": "expand-out 2.5s ease-in-out",
                "slide-menu": "slide-menu .5s ease-in-out",
            },
            keyframes: {
                "fade-in": {
                    "0%": { opacity: 0 },
                    "100%": { opacity: 1 },
                },
                "expand-in": {
                    "0%": { opacity: 0, transform: "scale(0.5)" },
                    "100%": { opacity: 1, transform: "scale(1)" },
                },
                "expand-out": {
                    "0%": { opacity: 1, transform: "scale(1)" },
                    "100%": { opacity: 0, transform: "scale(0.5)" },
                },
                "slide-menu": {
                    "0%": { transform: "translateY(-100%)" },
                    "100%": { transform: "translateX(0)" },
                },
            },
            plugins: [
                require("@tailwindcss/typography"),
                require("@tailwindcss/forms"),
            ],
        },
    },
};