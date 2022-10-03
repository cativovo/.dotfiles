local M = {}

local function setup()
  vim.g.user_emmet_leader_key = '<C-y>'
  vim.g.user_emmet_expandabbr_key = '<C-y>,'
  vim.g.user_emmet_expandword_key = '<C-y>;'
  vim.g.user_emmet_update_tag = '<C-y>u'
  vim.g.user_emmet_balancetaginward_key = '<C-y>d'
  vim.g.user_emmet_balancetagoutward_key = '<C-y>D'
  vim.g.user_emmet_next_key = '<C-y>l'
  vim.g.user_emmet_prev_key = '<C-y>h'
  vim.g.user_emmet_imagesize_key = '<C-y>i'
  vim.g.user_emmet_togglecomment_key = '<C-y>/'
  vim.g.user_emmet_splitjointag_key = '<C-y>j'
  vim.g.user_emmet_removetag_key = '<C-y>k'
  vim.g.user_emmet_anchorizeurl_key = '<C-y>a'
  vim.g.user_emmet_anchorizesummary_key = '<C-y>A'
  vim.g.user_emmet_mergelines_key = '<C-y>m'
  vim.g.user_emmet_codepretty_key = '<C-y>c'
end

M.config = function()
  setup()
end

return M
