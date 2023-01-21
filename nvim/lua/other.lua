-- require('Comment').setup()
-- require('toggleterm').setup({
--   direction = 'float',
--   open_mapping = [[<c-\>]]
-- })
-- import gitsigns plugin safely
local setup, todoComments = pcall(require, "todo-comments")
if not setup then
  return
end
todoComments.setup()

-- import gitsigns plugin safely
local setup1, gitsigns = pcall(require, "gitsigns")
if not setup1 then
  return
end

-- configure/enable gitsigns
gitsigns.setup()

