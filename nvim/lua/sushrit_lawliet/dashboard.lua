local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- print("dashboard.setup()")

-- Set header
dashboard.section.header.val = {
    "",
    "",
    -- "",
    -- "                                                     ",
    -- "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    -- "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    -- "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    -- "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    -- "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    -- "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    -- "                                                     ",
	-- "⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⡶⣶⣶⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
	-- "⠀⠀⠀⠀⠀⢠⣴⡿⠫⠓⠿⠛⠉⠀⢀⣙⠷⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
	-- "⠀⠀⠀⠀⠀⣾⠏⣴⠕⢁⠀⠀⠀⢺⣿⣿⣧⠀⢳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
	-- "⠀⠀⠀⠀⢸⣯⡾⢡⠣⠃⠀⠀⠒⢘⣿⣿⣿⣇⠸⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
	-- "⠀⠀⠀⠀⠺⣿⣴⣧⡄⢀⣀⣰⣶⣶⣿⣻⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
	-- "⠀⠀⠀⠀⢺⣿⣿⣿⠛⠐⠀⠈⠉⢹⣏⣧⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
	-- "⠀⠀⠀⠀⠘⣿⣿⣿⣆⠀⠀⠀⠀⢸⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
	-- "⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⡿⠀⠁⠛⢻⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
	-- "⠀⠀⠀⠀⠀⠀⠿⣿⣿⣾⡴⡂⠀⠀⣙⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
	-- "⠀⠀⠀⠀⠀⠀⣀⣿⣿⣟⠀⠀⠹⣻⣿⣿⡿⣷⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
	-- "⣠⣴⣶⣶⣿⣿⣿⡯⠻⣿⣇⠀⠀⢻⣿⣿⢳⣿⣿⣿⣷⣦⣄⠀⠀⠀⠀⠀⠀⠀", 
	-- "⣿⣿⣿⣿⣿⡏⣿⣇⠀⠈⠻⣷⢴⠿⠈⢡⣿⣿⠋⣾⣿⣿⣿⣿⣶⣶⣶⣄⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⡶⣶⣶⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
	"⠀⠀⠀⠀⠀⢠⣴⡿⠫⠓⠿⠛⠉⠀⢀⣙⠷⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
	"⠀⠀⠀⠀⠀⣾⠏⣴⠕⢁⠀⠀⠀⢺⣿⣿⣧⠀⢳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
	"⠀⠀⠀⠀⢸⣯⡾⢡⠣⠃⠀⠀⠒⢘⣿⣿⣿⣇⠸⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
	"⠀⠀⠀⠀⠺⣿⣴⣧⡄⢀⣀⣰⣶⣶⣿⣻⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
	"⠀⠀⠀⠀⢺⣿⣿⣿⠛⠐⠀⠈⠉⢹⣏⣧⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
	"⠀⠀⠀⠀⠘⣿⣿⣿⣆⠀⠀⠀⠀⢸⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀██╗  ██╗███████╗██╗     ██╗      ██████╗     ████████╗██╗  ██╗███████╗██████╗ ███████╗", 
	"⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⡿⠀⠁⠛⢻⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀██║  ██║██╔════╝██║     ██║     ██╔═══██╗    ╚══██╔══╝██║  ██║██╔════╝██╔══██╗██╔════╝", 
	"⠀⠀⠀⠀⠀⠀⠿⣿⣿⣾⡴⡂⠀⠀⣙⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀███████║█████╗  ██║     ██║     ██║   ██║       ██║   ███████║█████╗  ██████╔╝█████╗  ", 
	"⠀⠀⠀⠀⠀⠀⣀⣿⣿⣟⠀⠀⠹⣻⣿⣿⡿⣷⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀██╔══██║██╔══╝  ██║     ██║     ██║   ██║       ██║   ██╔══██║██╔══╝  ██╔══██╗██╔══╝  ", 
	"⣠⣴⣶⣶⣿⣿⣿⡯⠻⣿⣇⠀⠀⢻⣿⣿⢳⣿⣿⣿⣷⣦⣄⠀⠀⠀⠀⠀⠀⠀██║  ██║███████╗███████╗███████╗╚██████╔╝       ██║   ██║  ██║███████╗██║  ██║███████╗", 
	"⣿⣿⣿⣿⣿⡏⣿⣇⠀⠈⠻⣷⢴⠿⠈⢡⣿⣿⠋⣾⣿⣿⣿⣿⣶⣶⣶⣄⠀⠀╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝ ╚═════╝        ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝",
"	",
-- "██╗  ██╗███████╗██╗     ██╗      ██████╗     ████████╗██╗  ██╗███████╗██████╗ ███████╗",
-- "██║  ██║██╔════╝██║     ██║     ██╔═══██╗    ╚══██╔══╝██║  ██║██╔════╝██╔══██╗██╔════╝",
-- "███████║█████╗  ██║     ██║     ██║   ██║       ██║   ███████║█████╗  ██████╔╝█████╗  ",
-- "██╔══██║██╔══╝  ██║     ██║     ██║   ██║       ██║   ██╔══██║██╔══╝  ██╔══██╗██╔══╝  ",
-- "██║  ██║███████╗███████╗███████╗╚██████╔╝       ██║   ██║  ██║███████╗██║  ██║███████╗",
-- "╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝ ╚═════╝        ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝",
-- "Hello there.",
}

dashboard.section.footer.val = {
-- "",
-- "                                                       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠤⠀⡀⠤⠤⢀⣀⠀⣀⡠⠤⠒⠊⠉⠉⠒⢤⣀⠤⣒⠊⠉⠉⠀⠀⠀⠀",
-- "                                                       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢇⠀⠀⠀⠀⠀⠀⣀⣠⡴⠋⠀⠀⡰⠁⠀⢀⠀⠈⠉⢢⣤⠶⠊⠙⠛⠋⢳⠆⠀⠢⡈⠣⡀⠀⠀⠀⠀⠀",
-- "                                                       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣧⠀⠀⣀⠔⢋⣥⠊⣰⡇⠀⢠⠃⠀⠀⣾⡄⠀⠀⠈⠈⠳⣄⣀⣠⡴⣾⣄⠀⠀⠘⠀⠀⠀⠀⠀⠀⠀",
-- "                                                       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣷⠊⠁⢰⢁⠇⠐⣿⠁⠀⠀⠀⠀⠀⣿⠃⠀⠀⠀⡇⠀⠈⢿⣿⣷⡏⢻⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀",
-- "                                                       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠔⡻⡿⣿⣦⣌⡌⠀⠀⢻⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⢰⠀⠀⠈⣿⣼⣇⠀⠙⢿⣷⣥⠀⠀⠀⠀⠀⠀",
-- "                                                       ⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡎⢠⣿⠃⣨⣿⢿⠃⠀⠀⢸⡀⠀⠀⠀⠀⠀⢸⡆⠀⠀⠀⠀⢣⠀⡼⠉⠹⢿⣧⠀⠸⣿⣿⣄⠀⠀⠀⠀⠀",
-- "                                                       ⠀⠀⠀⠀⠀⠀⠀⢠⠏⢹⠁⣮⡇⢠⣿⣟⡏⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠈⣷⠀⢀⢤⣤⠀⠻⡷⢠⠇⢸⡏⣆⣀⢿⣿⣿⣷⡀⠀⠀⠀",
-- "                                                       ⠀⠀⠀⠀⠀⢀⡔⠁⢠⣿⠀⣿⣇⠀⡏⢀⠃⢀⣀⣀⣀⣷⡀⢀⠀⠀⠀⢠⣿⣙⣧⠾⢿⣧⠀⠰⣸⠀⣸⢡⡶⠎⣿⣿⣿⣿⠀⢰⡄⠀",
-- "                                                       ⠀⠀⠀⠀⠀⣼⡄⠀⢸⣿⠀⢸⣶⣶⣃⡎⠸⣿⣿⣧⣼⡧⡟⠸⠀⠀⠀⠈⢿⡯⢭⠭⠞⣻⠀⠀⡟⣶⠟⣛⡓⢠⣿⣿⣿⣿⠀⠘⣿⡄",
-- "                                                       ⠀⠀⠀⠀⢾⠠⣧⠀⠀⡇⢃⠘⡙⢎⣛⡇⠀⠹⡗⠒⠚⣻⠃⠀⡆⠀⠀⠀⠀⠈⠑⠒⠊⠁⠀⣰⢟⣡⠾⣯⢁⣿⣿⣿⣿⣿⠀⠀⣿⣿",
-- "                                                       ⠀⠀⠀⡔⠺⠀⠹⣦⠀⠱⡜⡆⢣⠸⡿⣷⡄⠀⠙⠓⠈⠁⠀⠀⢡⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⡿⢻⡆⣸⣿⣿⣿⣿⣿⣧⠀⠟⠛",
-- "                                                       ⢀⡤⠔⠓⡄⡆⠀⠹⣧⠠⡘⢿⡈⠳⢍⣩⣾⣦⣄⣀⠀⠀⠀⠀⠈⡆⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⠀⢸⠀⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀",
-- "                                                       ⢯⠀⠀⠀⢱⠘⢄⠀⠙⢧⠘⡄⠁⢀⠈⠛⢿⡄⠹⣿⣿⣆⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣽⡄⢸⢸⣿⣿⣿⣿⣿⠁⣿⠇⠀⠀",
-- "                                                       ⠀⠣⡀⠀⢸⢆⠀⢳⣄⠀⠀⠈⢆⠈⢆⠀⠈⠻⡆⢻⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⡇⠈⣼⣿⣿⣿⣿⣿⣴⡿⠀⠀⠀",
-- "                                                       ⠀⠀⠁⠀⠘⢌⢣⡀⠉⢷⣄⠀⠈⠳⡀⠳⣄⠀⠙⡌⣿⣆⣸⡄⠀⠀⢀⣀⠀⡤⠀⠄⠀⠸⣿⣿⣿⠿⡀⠹⠿⢿⣿⣿⣿⡟⠁⠀⠀⠀",
-- "                                                       ⠀⠀⠀⠈⠱⡀⠙⢜⣦⡀⠙⢆⠀⠀⠘⠦⡘⢿⣆⠙⣬⢻⢻⣇⠀⡄⠈⠘⠀⠀⠀⠀⠀⠀⢹⣿⠏⠐⢧⠀⠀⠀⢹⣠⡏⠀⠀⠀⠀⠀",
-- "                                                       ⠀⠀⠀⠀⠀⠈⠢⡀⠉⠻⣦⠀⠣⠀⠀⠀⢹⣦⠙⣿⣿⠈⢧⣹⡀⢱⠀⠈⠀⠀⠀⠂⠀⡄⢾⣯⣶⣤⣬⢧⣤⡴⠊⡝⠀⠀⣠⠀⠀⠀",
-- "                                                       ⠀⠀⠂⠀⠀⠀⠀⠈⠢⡀⠀⠑⠦⡀⠀⠐⠻⣇⣣⡈⢻⡆⠀⠙⡟⠀⠀⠀⠀⠀⢂⠀⢳⣷⠀⢻⣿⣿⣿⣾⣿⠷⠊⠀⢀⣼⡟⠀⠀⠀",
-- "                                                       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢄⠀⠀⠀⠀⠀⠀⠀⠙⢷⣄⠓⠀⠀⠱⡀⠐⠆⢘⡠⠤⠒⠒⠘⢦⡬⠉⠉⠉⠉⠀⢀⡠⠒⠁⡜⠀⠀⠀⠀",
-- "                                                       ⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠀⠀⠀⠑⢴⣎⠁⠀⠀⠀⠀⠀⠀⠑⠦⣄⣀⡀⡀⣀⡠⠤⠚⠀⠀⠀⠀⠀",
"",
-- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠤⠀⡀⠤⠤⢀⣀⠀⣀⡠⠤⠒⠊⠉⠉⠒⢤⣀⠤⣒⠊⠉⠉⠀⠀⠀⠀",
-- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢇⠀⠀⠀⠀⠀⠀⣀⣠⡴⠋⠀⠀⡰⠁⠀⢀⠀⠈⠉⢢⣤⠶⠊⠙⠛⠋⢳⠆⠀⠢⡈⠣⡀⠀⠀⠀⠀⠀",
-- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣧⠀⠀⣀⠔⢋⣥⠊⣰⡇⠀⢠⠃⠀⠀⣾⡄⠀⠀⠈⠈⠳⣄⣀⣠⡴⣾⣄⠀⠀⠘⠀⠀⠀⠀⠀⠀⠀",
-- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣷⠊⠁⢰⢁⠇⠐⣿⠁⠀⠀⠀⠀⠀⣿⠃⠀⠀⠀⡇⠀⠈⢿⣿⣷⡏⢻⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀",
-- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠔⡻⡿⣿⣦⣌⡌⠀⠀⢻⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⢰⠀⠀⠈⣿⣼⣇⠀⠙⢿⣷⣥⠀⠀⠀⠀⠀⠀",
-- "⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡎⢠⣿⠃⣨⣿⢿⠃⠀⠀⢸⡀⠀⠀⠀⠀⠀⢸⡆⠀⠀⠀⠀⢣⠀⡼⠉⠹⢿⣧⠀⠸⣿⣿⣄⠀⠀⠀⠀⠀",
-- "⠀⠀⠀⠀⠀⠀⠀⢠⠏⢹⠁⣮⡇⢠⣿⣟⡏⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠈⣷⠀⢀⢤⣤⠀⠻⡷⢠⠇⢸⡏⣆⣀⢿⣿⣿⣷⡀⠀⠀⠀",
-- "⠀⠀⠀⠀⠀⢀⡔⠁⢠⣿⠀⣿⣇⠀⡏⢀⠃⢀⣀⣀⣀⣷⡀⢀⠀⠀⠀⢠⣿⣙⣧⠾⢿⣧⠀⠰⣸⠀⣸⢡⡶⠎⣿⣿⣿⣿⠀⢰⡄⠀",
-- "⠀⠀⠀⠀⠀⣼⡄⠀⢸⣿⠀⢸⣶⣶⣃⡎⠸⣿⣿⣧⣼⡧⡟⠸⠀⠀⠀⠈⢿⡯⢭⠭⠞⣻⠀⠀⡟⣶⠟⣛⡓⢠⣿⣿⣿⣿⠀⠘⣿⡄",
-- "⠀⠀⠀⠀⢾⠠⣧⠀⠀⡇⢃⠘⡙⢎⣛⡇⠀⠹⡗⠒⠚⣻⠃⠀⡆⠀⠀⠀⠀⠈⠑⠒⠊⠁⠀⣰⢟⣡⠾⣯⢁⣿⣿⣿⣿⣿⠀⠀⣿⣿",
-- "⠀⠀⠀⡔⠺⠀⠹⣦⠀⠱⡜⡆⢣⠸⡿⣷⡄⠀⠙⠓⠈⠁⠀⠀⢡⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⡿⢻⡆⣸⣿⣿⣿⣿⣿⣧⠀⠟⠛",
-- "⢀⡤⠔⠓⡄⡆⠀⠹⣧⠠⡘⢿⡈⠳⢍⣩⣾⣦⣄⣀⠀⠀⠀⠀⠈⡆⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⠀⢸⠀⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀",
-- "⢯⠀⠀⠀⢱⠘⢄⠀⠙⢧⠘⡄⠁⢀⠈⠛⢿⡄⠹⣿⣿⣆⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣽⡄⢸⢸⣿⣿⣿⣿⣿⠁⣿⠇⠀⠀",
-- "⠀⠣⡀⠀⢸⢆⠀⢳⣄⠀⠀⠈⢆⠈⢆⠀⠈⠻⡆⢻⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⡇⠈⣼⣿⣿⣿⣿⣿⣴⡿⠀⠀⠀",
-- "⠀⠀⠁⠀⠘⢌⢣⡀⠉⢷⣄⠀⠈⠳⡀⠳⣄⠀⠙⡌⣿⣆⣸⡄⠀⠀⢀⣀⠀⡤⠀⠄⠀⠸⣿⣿⣿⠿⡀⠹⠿⢿⣿⣿⣿⡟⠁⠀⠀⠀",
-- "⠀⠀⠀⠈⠱⡀⠙⢜⣦⡀⠙⢆⠀⠀⠘⠦⡘⢿⣆⠙⣬⢻⢻⣇⠀⡄⠈⠘⠀⠀⠀⠀⠀⠀⢹⣿⠏⠐⢧⠀⠀⠀⢹⣠⡏⠀⠀⠀⠀⠀",
-- "⠀⠀⠀⠀⠀⠈⠢⡀⠉⠻⣦⠀⠣⠀⠀⠀⢹⣦⠙⣿⣿⠈⢧⣹⡀⢱⠀⠈⠀⠀⠀⠂⠀⡄⢾⣯⣶⣤⣬⢧⣤⡴⠊⡝⠀⠀⣠⠀⠀⠀",
-- "⠀⠀⠂⠀⠀⠀⠀⠈⠢⡀⠀⠑⠦⡀⠀⠐⠻⣇⣣⡈⢻⡆⠀⠙⡟⠀⠀⠀⠀⠀⢂⠀⢳⣷⠀⢻⣿⣿⣿⣾⣿⠷⠊⠀⢀⣼⡟⠀⠀⠀",
-- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢄⠀⠀⠀⠀⠀⠀⠀⠙⢷⣄⠓⠀⠀⠱⡀⠐⠆⢘⡠⠤⠒⠒⠘⢦⡬⠉⠉⠉⠉⠀⢀⡠⠒⠁⡜⠀⠀⠀⠀",
-- "⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠀⠀⠀⠑⢴⣎⠁⠀⠀⠀⠀⠀⠀⠑⠦⣄⣀⡀⡀⣀⡠⠤⠚⠀⠀⠀⠀⠀",
"                                                               ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠤⠀⡀⠤⠤⢀⣀⠀⣀⡠⠤⠒⠊⠉⠉⠒⢤⣀⠤⣒⠊⠉⠉⠀⠀⠀⠀",
"                                                               ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢇⠀⠀⠀⠀⠀⠀⣀⣠⡴⠋⠀⠀⡰⠁⠀⢀⠀⠈⠉⢢⣤⠶⠊⠙⠛⠋⢳⠆⠀⠢⡈⠣⡀⠀⠀⠀⠀⠀",
"                                                               ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣧⠀⠀⣀⠔⢋⣥⠊⣰⡇⠀⢠⠃⠀⠀⣾⡄⠀⠀⠈⠈⠳⣄⣀⣠⡴⣾⣄⠀⠀⠘⠀⠀⠀⠀⠀⠀⠀",
"                                                               ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣷⠊⠁⢰⢁⠇⠐⣿⠁⠀⠀⠀⠀⠀⣿⠃⠀⠀⠀⡇⠀⠈⢿⣿⣷⡏⢻⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀",
"                                                               ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠔⡻⡿⣿⣦⣌⡌⠀⠀⢻⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⢰⠀⠀⠈⣿⣼⣇⠀⠙⢿⣷⣥⠀⠀⠀⠀⠀⠀",
"                                                               ⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡎⢠⣿⠃⣨⣿⢿⠃⠀⠀⢸⡀⠀⠀⠀⠀⠀⢸⡆⠀⠀⠀⠀⢣⠀⡼⠉⠹⢿⣧⠀⠸⣿⣿⣄⠀⠀⠀⠀⠀",
"                                                               ⠀⠀⠀⠀⠀⠀⠀⢠⠏⢹⠁⣮⡇⢠⣿⣟⡏⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠈⣷⠀⢀⢤⣤⠀⠻⡷⢠⠇⢸⡏⣆⣀⢿⣿⣿⣷⡀⠀⠀⠀",
"                                                               ⠀⠀⠀⠀⠀⢀⡔⠁⢠⣿⠀⣿⣇⠀⡏⢀⠃⢀⣀⣀⣀⣷⡀⢀⠀⠀⠀⢠⣿⣙⣧⠾⢿⣧⠀⠰⣸⠀⣸⢡⡶⠎⣿⣿⣿⣿⠀⢰⡄⠀",
" ██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ██╗         ⠀⠀⠀⠀⠀⣼⡄⠀⢸⣿⠀⢸⣶⣶⣃⡎⠸⣿⣿⣧⣼⡧⡟⠸⠀⠀⠀⠈⢿⡯⢭⠭⠞⣻⠀⠀⡟⣶⠟⣛⡓⢠⣿⣿⣿⣿⠀⠘⣿⡄",
"██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗██║         ⠀⠀⠀⠀⢾⠠⣧⠀⠀⡇⢃⠘⡙⢎⣛⡇⠀⠹⡗⠒⠚⣻⠃⠀⡆⠀⠀⠀⠀⠈⠑⠒⠊⠁⠀⣰⢟⣡⠾⣯⢁⣿⣿⣿⣿⣿⠀⠀⣿⣿",
"██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║██║         ⠀⠀⠀⡔⠺⠀⠹⣦⠀⠱⡜⡆⢣⠸⡿⣷⡄⠀⠙⠓⠈⠁⠀⠀⢡⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⡿⢻⡆⣸⣿⣿⣿⣿⣿⣧⠀⠟⠛",
"██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║██║         ⢀⡤⠔⠓⡄⡆⠀⠹⣧⠠⡘⢿⡈⠳⢍⣩⣾⣦⣄⣀⠀⠀⠀⠀⠈⡆⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⠀⢸⠀⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀",
"╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║███████╗    ⢯⠀⠀⠀⢱⠘⢄⠀⠙⢧⠘⡄⠁⢀⠈⠛⢿⡄⠹⣿⣿⣆⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣽⡄⢸⢸⣿⣿⣿⣿⣿⠁⣿⠇⠀⠀",
" ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝    ⠀⠣⡀⠀⢸⢆⠀⢳⣄⠀⠀⠈⢆⠈⢆⠀⠈⠻⡆⢻⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⡇⠈⣼⣿⣿⣿⣿⣿⣴⡿⠀⠀⠀",
"██╗  ██╗███████╗███╗   ██╗ ██████╗ ██████╗ ██╗                 ⠀⠀⠁⠀⠘⢌⢣⡀⠉⢷⣄⠀⠈⠳⡀⠳⣄⠀⠙⡌⣿⣆⣸⡄⠀⠀⢀⣀⠀⡤⠀⠄⠀⠸⣿⣿⣿⠿⡀⠹⠿⢿⣿⣿⣿⡟⠁⠀⠀⠀",
"██║ ██╔╝██╔════╝████╗  ██║██╔═══██╗██╔══██╗██║                 ⠀⠀⠀⠈⠱⡀⠙⢜⣦⡀⠙⢆⠀⠀⠘⠦⡘⢿⣆⠙⣬⢻⢻⣇⠀⡄⠈⠘⠀⠀⠀⠀⠀⠀⢹⣿⠏⠐⢧⠀⠀⠀⢹⣠⡏⠀⠀⠀⠀⠀",
"█████╔╝ █████╗  ██╔██╗ ██║██║   ██║██████╔╝██║                 ⠀⠀⠀⠀⠀⠈⠢⡀⠉⠻⣦⠀⠣⠀⠀⠀⢹⣦⠙⣿⣿⠈⢧⣹⡀⢱⠀⠈⠀⠀⠀⠂⠀⡄⢾⣯⣶⣤⣬⢧⣤⡴⠊⡝⠀⠀⣠⠀⠀⠀",
"██╔═██╗ ██╔══╝  ██║╚██╗██║██║   ██║██╔══██╗██║                 ⠀⠀⠂⠀⠀⠀⠀⠈⠢⡀⠀⠑⠦⡀⠀⠐⠻⣇⣣⡈⢻⡆⠀⠙⡟⠀⠀⠀⠀⠀⢂⠀⢳⣷⠀⢻⣿⣿⣿⣾⣿⠷⠊⠀⢀⣼⡟⠀⠀⠀",
"██║  ██╗███████╗██║ ╚████║╚██████╔╝██████╔╝██║                 ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢄⠀⠀⠀⠀⠀⠀⠀⠙⢷⣄⠓⠀⠀⠱⡀⠐⠆⢘⡠⠤⠒⠒⠘⢦⡬⠉⠉⠉⠉⠀⢀⡠⠒⠁⡜⠀⠀⠀⠀",
"╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚═╝                 ⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠀⠀⠀⠑⢴⣎⠁⠀⠀⠀⠀⠀⠀⠑⠦⣄⣀⡀⡀⣀⡠⠤⠚⠀⠀⠀⠀⠀",
"",
-- " ██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ██╗         ██╗  ██╗███████╗███╗   ██╗ ██████╗ ██████╗ ██╗",
-- "██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗██║         ██║ ██╔╝██╔════╝████╗  ██║██╔═══██╗██╔══██╗██║",
-- "██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║██║         █████╔╝ █████╗  ██╔██╗ ██║██║   ██║██████╔╝██║",
-- "██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║██║         ██╔═██╗ ██╔══╝  ██║╚██╗██║██║   ██║██╔══██╗██║",
-- "╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║███████╗    ██║  ██╗███████╗██║ ╚████║╚██████╔╝██████╔╝██║",
-- " ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝    ╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚═╝",
-- "General Kenobi",
}

-- Set menu
dashboard.section.buttons.val = {
	dashboard.button( "R", "🚀 > Restore Session" , ":SessionRestore <CR>"),
	dashboard.button( "S", "📗 > Browse Sessions" , ":Autosession search <CR>"),
    dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "  > Browse Files", ":Telescope find_files<CR>"),
    dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
}
--
-- dashboard.section.footer.opts.hl = "AlphaFooter"
-- dashboard.section.header.opts.hl = "AlphaHeader"
-- dashboard.section.buttons.opts.hl = "MoreMsg"
--
-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])

-- print("dashboard.setup() done")
--

