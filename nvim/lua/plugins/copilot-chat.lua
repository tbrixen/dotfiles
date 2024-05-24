return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
      debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
      disable_extra_info = "no", -- Disable extra information (e.g: system prompt) in the response.
      language = "English", -- Copilot answer language settings when using default prompts. Default language is English.
      -- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
      -- temperature = 0.1,
      prompts = {
        -- For more prompts, see https://github.com/DxCx/dxvim/blob/a18692c05301ea9111257662a8ca7a3e41b63b0e/packages/neovim/config/copilot/init.lua#L7
        Explain = "Explain how it works.",
        Review = "Review the following code and provide concise suggestions.",
        Tests = "Briefly explain how the selected code works, then generate unit tests.",
        Refactor = "Refactor the code to improve clarity and readability.",
        TextEnhance = "\
          I'd like you to look at the text I wrote and edit it to make it sound more natural to a native English speaker. \
          Do only minimal/minor edits without changing the text's tone.",
        TextSummarize = "\
          You are an expert content summarizer. \
          You take content in and output a Markdown formatted summary using the format below. \
          Take a deep breath and think step by step about how to best accomplish this goal using the following steps. \
          Combine all of your understanding of the content into a single, 20-word sentence in a section called ONE SENTENCE SUMMARY:. \
          Output the 10 most important points of the content as a list with no more than 15 words per point into a section called MAIN POINTS:. \
          Output a list of the 5 best takeaways from the content in a section called TAKEAWAYS:.",
        TextSummarizeTwo = "Please summarize the following text.",
        TextSpelling = "Please correct any grammar and spelling errors in the following text.",
        TextWording = "Please improve the grammar and wording of the following text.",
        TextConcise = "Please rewrite the following text to make it more concise.",
        TextMadrFeedback = "\
          You are an expert in the Markdown Any Decision Records (MADR) format. \
          You are my writing coach, helping make clear and concise MADRs. \
          Slowly listen to the input given, and spend 4 hours of virtual time thinking about what they were probably thinking when they created the input.. \
          In a section called RECOMMENDATIONS, give up to 5 bullet-points on providing a better MADR. \
          In a section called EXAMPLES, take each recommendataion from the RECOMMENDATIONS sections, and provide up to 3 implementations of the recommendatios",
      },
    },
    build = function()
      vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
    end,
    event = "VeryLazy",
    keys = {
      { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
      {
        "<leader>ccT",
        "<cmd>CopilotChatVsplitToggle<cr>",
        desc = "CopilotChat - Toggle Vsplit", -- Toggle vertical split
      },
      {
        "<leader>ccte",
        ":CopilotChatTextEnhance ",
        mode = "v",
        desc = "CopilotChat - Enhance text",
      },
      {
        "<leader>cctz",
        ":CopilotChatTextSummarize ",
        mode = "v",
        desc = "CopilotChat - Summarize text",
      },
      {
        "<leader>ccts",
        ":CopilotChatTextSpelling ",
        mode = "v",
        desc = "CopilotChat - Fix grammar and spelling",
      },
      {
        "<leader>cctw",
        ":CopilotChatTextWording ",
        mode = "v",
        desc = "CopilotChat - Improve grammar and wording",
      },
      {
        "<leader>cctc",
        ":CopilotChatTextConcise ",
        mode = "v",
        desc = "CopilotChat - Rewrite to make it more concise",
      },
      {
        "<leader>ccf",
        "<cmd>CopilotChatFixDiagnostic<cr>", -- Get a fix for the diagnostic message under the cursor.
        desc = "CopilotChat - Fix diagnostic",
      },
      {
        "<leader>ccr",
        "<cmd>CopilotChatReset<cr>", -- Reset chat history and clear buffer.
        desc = "CopilotChat - Reset chat history and clear buffer",
      },
      -- Show help actions with telescope
      {
        "<leader>cch",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.help_actions())
        end,
        desc = "CopilotChat - Help actions",
      },
      -- Show prompts actions with telescope
      {
        "<leader>ccp",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        mode = "v",
        desc = "CopilotChat - Prompt actions",
      },
      -- Quick chat with Copilot
      {
        "<leader>ccq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "CopilotChat - Quick chat",
      },
    },
  },
}
