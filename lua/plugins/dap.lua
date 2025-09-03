return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			dap.adapters.cpp = {
				type = "executable",
				command = "gdb",
				args = { "-i", "dap" },
			}

			dap.configurations.cpp = {
				{
					name = "Launch C++ program",
					type = "cpp",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
			}

			dap.configurations.c = dap.configurations.cpp

			dap.adapters.python = {
				type = "executable",
				command = "python3",
				args = { "-Xfrozen_modules=off", "-m", "debugpy.adapter" },
			}

			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch Python file",
					program = "${file}", -- current buffer
					pythonPath = function()
						return "python3"
					end,
				},
			}

			vim.keymap.set("n", "<space>sb", dap.toggle_breakpoint) -- Set break point
			vim.keymap.set("n", "<space>gb", dap.run_to_cursor) -- Run cursor

			-- Eval var under cursor
			vim.keymap.set("n", "<space>?", function()
				require("dapui").eval(nil, { enter = true })
			end)

			vim.keymap.set("n", "<F1>", dap.continue)
			vim.keymap.set("n", "<F2>", dap.step_into)
			vim.keymap.set("n", "<F3>", dap.step_over)
			vim.keymap.set("n", "<F4>", dap.step_out)
			vim.keymap.set("n", "<F5>", dap.step_back)
			vim.keymap.set("n", "<F13>", dap.restart)

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end
		end,
	},
}
