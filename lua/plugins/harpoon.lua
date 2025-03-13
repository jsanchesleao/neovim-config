return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { '<leader>hh', function() 
      local harpoon = require('harpoon')
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end,
    desc = "show harpoon files",
    },
    { '<leader>ha', function() 
      local harpoon = require('harpoon')
      harpoon:list():add()
    end,
    desc = "add file to harpoon",
    },
  },
}
