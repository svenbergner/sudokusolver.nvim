local M = {}

M.check = function()
    vim.health.start('sudokusolver report')
    vim.health.ok('sudokusolver is running')
end

return M

