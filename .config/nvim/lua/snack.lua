require("snacks").setup({
    scroll = { enabled = false },
    animate = { enabled = false },
    image = {
        enabled = true,
        inline = false,
        img_dirs = { "~/Pictures/" },
        doc = {
            enabled = true,
            conceal = function(lang, type)
                return type == "math"
            end,
        },
        math = {
            enabled = true,
            font_size = "Large",
        },
    },
})
