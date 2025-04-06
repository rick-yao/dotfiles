th.git = th.git or {}
th.git.modified = ui.Style():fg("blue")
th.git.deleted = ui.Style():fg("red"):bold()

th.git.modified_sign = "M"
th.git.deleted_sign = "D"
th.git.ignored_sign = "I"
th.git.added_sign = "A"
th.git.updated_sign = "U"
th.git.untracked_sign = "??"
require("git"):setup()

require("starship"):setup()
