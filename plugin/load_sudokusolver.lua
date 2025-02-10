vim.api.nvim_create_user_command("SudokuSolverStart", function ()
  -- Easy Reloading
  package.loaded["sudokusolver"] = nil

  require("sudokusolver").start_sudokusolver()
end, {})
