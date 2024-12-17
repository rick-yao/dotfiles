THEME.git = THEME.git or {}
THEME.git.modified = ui.Style():fg("blue")
THEME.git.deleted = ui.Style():fg("red"):bold()

THEME.git.modified_sign = "M"
THEME.git.deleted_sign = "D"
THEME.git.ignored_sign = "I"
THEME.git.added_sign = "A"
THEME.git.updated_sign = "U"
THEME.git.untracked_sign = "??"
require("git"):setup()

require("starship"):setup()
