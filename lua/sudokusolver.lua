local M = {}

local function is_valid(sudoku, row, col, num)
  for i = 1, 9 do
    if sudoku[row][i] == num or sudoku[i][col] == num then
      return false
    end
  end
  local start_row = row - (row - 1) % 3
  local start_col = col - (col - 1) % 3
  for i = 0, 2 do
    for j = 0, 2 do
      if sudoku[i + start_row][j + start_col] == num then
        return false
      end
    end
  end
  return true
end

local function solve(sudoku)
  for row = 1, 9 do
    for col = 1, 9 do
      if sudoku[row][col] == 0 then
        for num = 1, 9 do
          if is_valid(sudoku, row, col, num) then
            sudoku[row][col] = num
            if solve(sudoku) then
              return true, sudoku
            else
              sudoku[row][col] = 0
            end
          end
        end
        return false, sudoku
      end
    end
  end
  return true, sudoku
end

M.start_sudokusolver = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 9, true)
  local sudoku = {}
  for i, line in ipairs(lines) do
    sudoku[i] = {}
    for num in line:gmatch("%d") do
      table.insert(sudoku[i], tonumber(num))
    end
  end
  local is_solved, solved_sudoku = solve(sudoku)
  local solved_lines = {}
  for _, row in ipairs(solved_sudoku) do
    table.insert(solved_lines, table.concat(row, " "))
  end
  vim.api.nvim_buf_set_lines(bufnr, 0, 9, true, solved_lines)
  if is_solved then
    vim.api.nvim_buf_set_lines(bufnr, 10, -1, true, {" ", "󱜙 Sudoku solved!"})
  else
    vim.api.nvim_buf_set_lines(bufnr, 10, -1, true, {" ", "😥 No solution found!"})
  end
end

return M
