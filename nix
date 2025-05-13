{
	manager = {
		cwd = {
			fg = "#8bd5ca";
		};
		hovered = {
			fg = "#24273a";
			bg = "#f4dbd6";
		};
		preview_hovered = {
			fg = "#24273a";
			bg = "#cad3f5";
		};
		find_keyword = {
			fg = "#eed49f";
			italic = true;
		};
		find_position = {
			fg = "#f5bde6";
			bg = "reset";
			italic = true;
		};
		marker_copied = {
			fg = "#a6da95";
			bg = "#a6da95";
		};
		marker_cut = {
			fg = "#ed8796";
			bg = "#ed8796";
		};
		marker_marked = {
			fg = "#8bd5ca";
			bg = "#8bd5ca";
		};
		marker_selected = {
			fg = "#f4dbd6";
			bg = "#f4dbd6";
		};
		tab_active = {
			fg = "#24273a";
			bg = "#cad3f5";
		};
		tab_inactive = {
			fg = "#cad3f5";
			bg = "#494d64";
		};
		tab_width = 1;
		count_copied = {
			fg = "#24273a";
			bg = "#a6da95";
		};
		count_cut = {
			fg = "#24273a";
			bg = "#ed8796";
		};
		count_selected = {
			fg = "#24273a";
			bg = "#f4dbd6";
		};
		border_symbol = "│";
		border_style = {
			fg = "#8087a2";
		};
		syntect_theme = "~/.config/yazi/Catppuccin-macchiato.tmTheme";
	};
	mode = {
		normal_main = {
			fg = "#24273a";
			bg = "#f4dbd6";
			bold = true;
		};
		normal_alt = {
			fg = "#f4dbd6";
			bg = "#363a4f";
		};
		select_main = {
			fg = "#24273a";
			bg = "#a6da95";
			bold = true;
		};
		select_alt = {
			fg = "#a6da95";
			bg = "#363a4f";
		};
		unset_main = {
			fg = "#24273a";
			bg = "#f0c6c6";
			bold = true;
		};
		unset_alt = {
			fg = "#f0c6c6";
			bg = "#363a4f";
		};
	};
	status = {
		separator_open = "";
		separator_close = "";
		progress_label = {
			fg = "#ffffff";
			bold = true;
		};
		progress_normal = {
			fg = "#8aadf4";
			bg = "#494d64";
		};
		progress_error = {
			fg = "#ed8796";
			bg = "#494d64";
		};
		perm_type = {
			fg = "#8aadf4";
		};
		perm_read = {
			fg = "#eed49f";
		};
		perm_write = {
			fg = "#ed8796";
		};
		perm_exec = {
			fg = "#a6da95";
		};
		perm_sep = {
			fg = "#8087a2";
		};
	};
	input = {
		border = {
			fg = "#f4dbd6";
		};
		title = {
			
		};
		value = {
			
		};
		selected = {
			reversed = true;
		};
	};
	pick = {
		border = {
			fg = "#f4dbd6";
		};
		active = {
			fg = "#f5bde6";
		};
		inactive = {
			
		};
	};
	confirm = {
		border = {
			fg = "#f4dbd6";
		};
		title = {
			fg = "#f4dbd6";
		};
		content = {
			
		};
		list = {
			
		};
		btn_yes = {
			reversed = true;
		};
		btn_no = {
			
		};
	};
	cmp = {
		border = {
			fg = "#f4dbd6";
		};
	};
	tasks = {
		border = {
			fg = "#f4dbd6";
		};
		title = {
			
		};
		hovered = {
			underline = true;
		};
	};
	which = {
		mask = {
			bg = "#363a4f";
		};
		cand = {
			fg = "#8bd5ca";
		};
		rest = {
			fg = "#939ab7";
		};
		desc = {
			fg = "#f5bde6";
		};
		separator = "  ";
		separator_style = {
			fg = "#5b6078";
		};
	};
	help = {
		on = {
			fg = "#8bd5ca";
		};
		run = {
			fg = "#f5bde6";
		};
		desc = {
			fg = "#939ab7";
		};
		hovered = {
			bg = "#5b6078";
			bold = true;
		};
		footer = {
			fg = "#cad3f5";
			bg = "#494d64";
		};
	};
	notify = {
		title_info = {
			fg = "#8bd5ca";
		};
		title_warn = {
			fg = "#eed49f";
		};
		title_error = {
			fg = "#ed8796";
		};
	};
	filetype = {
		rules = [ {
			mime = "image/*";
			fg = "#8bd5ca";
		} {
			mime = "{audio,video}/*";
			fg = "#eed49f";
		} {
			mime = "application/*zip";
			fg = "#f5bde6";
		} {
			mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}";
			fg = "#f5bde6";
		} {
			mime = "application/{pdf,doc,rtf}";
			fg = "#a6da95";
		} {
			name = "*";
			fg = "#cad3f5";
		} {
			name = "*/";
			fg = "#f4dbd6";
		} ];
	};
	spot = {
		border = {
			fg = "#f4dbd6";
		};
		title = {
			fg = "#f4dbd6";
		};
		tbl_cell = {
			fg = "#f4dbd6";
			reversed = true;
		};
		tbl_col = {
			bold = true;
		};
	};
	icon = {
		files = [ {
			name = "kritadisplayrc";
			text = "";
			fg = "#c6a0f6";
		} {
			name = ".gtkrc-2.0";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "bspwmrc";
			text = "";
			fg = "#1e2030";
		} {
			name = "webpack";
			text = "󰜫";
			fg = "#7dc4e4";
		} {
			name = "tsconfig.json";
			text = "";
			fg = "#7dc4e4";
		} {
			name = ".vimrc";
			text = "";
			fg = "#a6da95";
		} {
			name = "gemfile$";
			text = "";
			fg = "#181926";
		} {
			name = "xmobarrc";
			text = "";
			fg = "#ed8796";
		} {
			name = "avif";
			text = "";
			fg = "#8087a2";
		} {
			name = "fp-info-cache";
			text = "";
			fg = "#f4dbd6";
		} {
			name = ".zshrc";
			text = "";
			fg = "#a6da95";
		} {
			name = "robots.txt";
			text = "󰚩";
			fg = "#6e738d";
		} {
			name = "dockerfile";
			text = "󰡨";
			fg = "#8aadf4";
		} {
			name = ".git-blame-ignore-revs";
			text = "";
			fg = "#f5a97f";
		} {
			name = ".nvmrc";
			text = "";
			fg = "#a6da95";
		} {
			name = "hyprpaper.conf";
			text = "";
			fg = "#8bd5ca";
		} {
			name = ".prettierignore";
			text = "";
			fg = "#8aadf4";
		} {
			name = "rakefile";
			text = "";
			fg = "#181926";
		} {
			name = "code_of_conduct";
			text = "";
			fg = "#ed8796";
		} {
			name = "cmakelists.txt";
			text = "";
			fg = "#cad3f5";
		} {
			name = ".env";
			text = "";
			fg = "#eed49f";
		} {
			name = "copying.lesser";
			text = "";
			fg = "#eed49f";
		} {
			name = "readme";
			text = "󰂺";
			fg = "#f4dbd6";
		} {
			name = "settings.gradle";
			text = "";
			fg = "#5b6078";
		} {
			name = "gruntfile.coffee";
			text = "";
			fg = "#f5a97f";
		} {
			name = ".eslintignore";
			text = "";
			fg = "#494d64";
		} {
			name = "kalgebrarc";
			text = "";
			fg = "#8aadf4";
		} {
			name = "kdenliverc";
			text = "";
			fg = "#8aadf4";
		} {
			name = ".prettierrc.cjs";
			text = "";
			fg = "#8aadf4";
		} {
			name = "cantorrc";
			text = "";
			fg = "#8aadf4";
		} {
			name = "rmd";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "vagrantfile$";
			text = "";
			fg = "#6e738d";
		} {
			name = ".Xauthority";
			text = "";
			fg = "#f5a97f";
		} {
			name = "prettier.config.ts";
			text = "";
			fg = "#8aadf4";
		} {
			name = "node_modules";
			text = "";
			fg = "#ed8796";
		} {
			name = ".prettierrc.toml";
			text = "";
			fg = "#8aadf4";
		} {
			name = "build.zig.zon";
			text = "";
			fg = "#f5a97f";
		} {
			name = ".ds_store";
			text = "";
			fg = "#494d64";
		} {
			name = "PKGBUILD";
			text = "";
			fg = "#8aadf4";
		} {
			name = ".prettierrc";
			text = "";
			fg = "#8aadf4";
		} {
			name = ".bash_profile";
			text = "";
			fg = "#a6da95";
		} {
			name = ".npmignore";
			text = "";
			fg = "#ed8796";
		} {
			name = ".mailmap";
			text = "󰊢";
			fg = "#f5a97f";
		} {
			name = ".codespellrc";
			text = "󰓆";
			fg = "#a6da95";
		} {
			name = "svelte.config.js";
			text = "";
			fg = "#f5a97f";
		} {
			name = "eslint.config.ts";
			text = "";
			fg = "#494d64";
		} {
			name = "config";
			text = "";
			fg = "#8087a2";
		} {
			name = ".gitlab-ci.yml";
			text = "";
			fg = "#ed8796";
		} {
			name = ".gitconfig";
			text = "";
			fg = "#f5a97f";
		} {
			name = "_gvimrc";
			text = "";
			fg = "#a6da95";
		} {
			name = ".xinitrc";
			text = "";
			fg = "#f5a97f";
		} {
			name = "checkhealth";
			text = "󰓙";
			fg = "#8aadf4";
		} {
			name = "sxhkdrc";
			text = "";
			fg = "#1e2030";
		} {
			name = ".bashrc";
			text = "";
			fg = "#a6da95";
		} {
			name = "tailwind.config.mjs";
			text = "󱏿";
			fg = "#7dc4e4";
		} {
			name = "ext_typoscript_setup.txt";
			text = "";
			fg = "#f5a97f";
		} {
			name = "commitlint.config.ts";
			text = "󰜘";
			fg = "#8bd5ca";
		} {
			name = "py.typed";
			text = "";
			fg = "#eed49f";
		} {
			name = ".nanorc";
			text = "";
			fg = "#24273a";
		} {
			name = "commit_editmsg";
			text = "";
			fg = "#f5a97f";
		} {
			name = ".luaurc";
			text = "";
			fg = "#8aadf4";
		} {
			name = "fp-lib-table";
			text = "";
			fg = "#f4dbd6";
		} {
			name = ".editorconfig";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "justfile";
			text = "";
			fg = "#8087a2";
		} {
			name = "kdeglobals";
			text = "";
			fg = "#8aadf4";
		} {
			name = "license.md";
			text = "";
			fg = "#eed49f";
		} {
			name = ".clang-format";
			text = "";
			fg = "#8087a2";
		} {
			name = "docker-compose.yaml";
			text = "󰡨";
			fg = "#8aadf4";
		} {
			name = "copying";
			text = "";
			fg = "#eed49f";
		} {
			name = "go.mod";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "lxqt.conf";
			text = "";
			fg = "#8aadf4";
		} {
			name = "brewfile";
			text = "";
			fg = "#181926";
		} {
			name = "gulpfile.coffee";
			text = "";
			fg = "#ed8796";
		} {
			name = ".dockerignore";
			text = "󰡨";
			fg = "#8aadf4";
		} {
			name = ".settings.json";
			text = "";
			fg = "#5b6078";
		} {
			name = "tailwind.config.js";
			text = "󱏿";
			fg = "#7dc4e4";
		} {
			name = ".clang-tidy";
			text = "";
			fg = "#8087a2";
		} {
			name = ".gvimrc";
			text = "";
			fg = "#a6da95";
		} {
			name = "nuxt.config.cjs";
			text = "󱄆";
			fg = "#8bd5ca";
		} {
			name = "xsettingsd.conf";
			text = "";
			fg = "#f5a97f";
		} {
			name = "nuxt.config.js";
			text = "󱄆";
			fg = "#8bd5ca";
		} {
			name = "eslint.config.cjs";
			text = "";
			fg = "#494d64";
		} {
			name = "sym-lib-table";
			text = "";
			fg = "#f4dbd6";
		} {
			name = ".condarc";
			text = "";
			fg = "#a6da95";
		} {
			name = "xmonad.hs";
			text = "";
			fg = "#ed8796";
		} {
			name = "tmux.conf";
			text = "";
			fg = "#a6da95";
		} {
			name = "xmobarrc.hs";
			text = "";
			fg = "#ed8796";
		} {
			name = ".prettierrc.yaml";
			text = "";
			fg = "#8aadf4";
		} {
			name = ".pre-commit-config.yaml";
			text = "󰛢";
			fg = "#eed49f";
		} {
			name = "i3blocks.conf";
			text = "";
			fg = "#cad3f5";
		} {
			name = "xorg.conf";
			text = "";
			fg = "#f5a97f";
		} {
			name = ".zshenv";
			text = "";
			fg = "#a6da95";
		} {
			name = "vlcrc";
			text = "󰕼";
			fg = "#f5a97f";
		} {
			name = "license";
			text = "";
			fg = "#eed49f";
		} {
			name = "unlicense";
			text = "";
			fg = "#eed49f";
		} {
			name = "tmux.conf.local";
			text = "";
			fg = "#a6da95";
		} {
			name = ".SRCINFO";
			text = "󰣇";
			fg = "#8aadf4";
		} {
			name = "tailwind.config.ts";
			text = "󱏿";
			fg = "#7dc4e4";
		} {
			name = "security.md";
			text = "󰒃";
			fg = "#b8c0e0";
		} {
			name = "security";
			text = "󰒃";
			fg = "#b8c0e0";
		} {
			name = ".eslintrc";
			text = "";
			fg = "#494d64";
		} {
			name = "gradle.properties";
			text = "";
			fg = "#5b6078";
		} {
			name = "code_of_conduct.md";
			text = "";
			fg = "#ed8796";
		} {
			name = "PrusaSlicerGcodeViewer.ini";
			text = "";
			fg = "#f5a97f";
		} {
			name = "PrusaSlicer.ini";
			text = "";
			fg = "#f5a97f";
		} {
			name = "procfile";
			text = "";
			fg = "#8087a2";
		} {
			name = "mpv.conf";
			text = "";
			fg = "#24273a";
		} {
			name = ".prettierrc.json5";
			text = "";
			fg = "#8aadf4";
		} {
			name = "i3status.conf";
			text = "";
			fg = "#cad3f5";
		} {
			name = "prettier.config.mjs";
			text = "";
			fg = "#8aadf4";
		} {
			name = ".pylintrc";
			text = "";
			fg = "#8087a2";
		} {
			name = "prettier.config.cjs";
			text = "";
			fg = "#8aadf4";
		} {
			name = ".luacheckrc";
			text = "";
			fg = "#8aadf4";
		} {
			name = "containerfile";
			text = "󰡨";
			fg = "#8aadf4";
		} {
			name = "eslint.config.mjs";
			text = "";
			fg = "#494d64";
		} {
			name = "gruntfile.js";
			text = "";
			fg = "#f5a97f";
		} {
			name = "bun.lockb";
			text = "";
			fg = "#f4dbd6";
		} {
			name = ".gitattributes";
			text = "";
			fg = "#f5a97f";
		} {
			name = "gruntfile.ts";
			text = "";
			fg = "#f5a97f";
		} {
			name = "pom.xml";
			text = "";
			fg = "#363a4f";
		} {
			name = "favicon.ico";
			text = "";
			fg = "#eed49f";
		} {
			name = "package-lock.json";
			text = "";
			fg = "#363a4f";
		} {
			name = "build";
			text = "";
			fg = "#a6da95";
		} {
			name = "package.json";
			text = "";
			fg = "#ed8796";
		} {
			name = "nuxt.config.ts";
			text = "󱄆";
			fg = "#8bd5ca";
		} {
			name = "nuxt.config.mjs";
			text = "󱄆";
			fg = "#8bd5ca";
		} {
			name = "mix.lock";
			text = "";
			fg = "#8087a2";
		} {
			name = "makefile";
			text = "";
			fg = "#8087a2";
		} {
			name = "gulpfile.js";
			text = "";
			fg = "#ed8796";
		} {
			name = "lxde-rc.xml";
			text = "";
			fg = "#8087a2";
		} {
			name = "kritarc";
			text = "";
			fg = "#c6a0f6";
		} {
			name = "gtkrc";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "ionic.config.json";
			text = "";
			fg = "#8aadf4";
		} {
			name = ".prettierrc.mjs";
			text = "";
			fg = "#8aadf4";
		} {
			name = ".prettierrc.yml";
			text = "";
			fg = "#8aadf4";
		} {
			name = ".npmrc";
			text = "";
			fg = "#ed8796";
		} {
			name = "weston.ini";
			text = "";
			fg = "#eed49f";
		} {
			name = "gulpfile.babel.js";
			text = "";
			fg = "#ed8796";
		} {
			name = "i18n.config.ts";
			text = "󰗊";
			fg = "#8087a2";
		} {
			name = "commitlint.config.js";
			text = "󰜘";
			fg = "#8bd5ca";
		} {
			name = ".gitmodules";
			text = "";
			fg = "#f5a97f";
		} {
			name = "gradle-wrapper.properties";
			text = "";
			fg = "#5b6078";
		} {
			name = "hypridle.conf";
			text = "";
			fg = "#8bd5ca";
		} {
			name = "vercel.json";
			text = "▲";
			fg = "#f4dbd6";
		} {
			name = "hyprlock.conf";
			text = "";
			fg = "#8bd5ca";
		} {
			name = "go.sum";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "kdenlive-layoutsrc";
			text = "";
			fg = "#8aadf4";
		} {
			name = "gruntfile.babel.js";
			text = "";
			fg = "#f5a97f";
		} {
			name = "compose.yml";
			text = "󰡨";
			fg = "#8aadf4";
		} {
			name = "i18n.config.js";
			text = "󰗊";
			fg = "#8087a2";
		} {
			name = "readme.md";
			text = "󰂺";
			fg = "#f4dbd6";
		} {
			name = "gradlew";
			text = "";
			fg = "#5b6078";
		} {
			name = "go.work";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "gulpfile.ts";
			text = "";
			fg = "#ed8796";
		} {
			name = "gnumakefile";
			text = "";
			fg = "#8087a2";
		} {
			name = "FreeCAD.conf";
			text = "";
			fg = "#ed8796";
		} {
			name = "compose.yaml";
			text = "󰡨";
			fg = "#8aadf4";
		} {
			name = "eslint.config.js";
			text = "";
			fg = "#494d64";
		} {
			name = "hyprland.conf";
			text = "";
			fg = "#8bd5ca";
		} {
			name = "docker-compose.yml";
			text = "󰡨";
			fg = "#8aadf4";
		} {
			name = "groovy";
			text = "";
			fg = "#5b6078";
		} {
			name = "QtProject.conf";
			text = "";
			fg = "#a6da95";
		} {
			name = "platformio.ini";
			text = "";
			fg = "#f5a97f";
		} {
			name = "build.gradle";
			text = "";
			fg = "#5b6078";
		} {
			name = ".nuxtrc";
			text = "󱄆";
			fg = "#8bd5ca";
		} {
			name = "_vimrc";
			text = "";
			fg = "#a6da95";
		} {
			name = ".zprofile";
			text = "";
			fg = "#a6da95";
		} {
			name = ".xsession";
			text = "";
			fg = "#f5a97f";
		} {
			name = "prettier.config.js";
			text = "";
			fg = "#8aadf4";
		} {
			name = ".babelrc";
			text = "";
			fg = "#eed49f";
		} {
			name = "workspace";
			text = "";
			fg = "#a6da95";
		} {
			name = ".prettierrc.json";
			text = "";
			fg = "#8aadf4";
		} {
			name = ".prettierrc.js";
			text = "";
			fg = "#8aadf4";
		} {
			name = ".Xresources";
			text = "";
			fg = "#f5a97f";
		} {
			name = ".gitignore";
			text = "";
			fg = "#f5a97f";
		} {
			name = ".justfile";
			text = "";
			fg = "#8087a2";
		} ];
		exts = [ {
			name = "otf";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "import";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "krz";
			text = "";
			fg = "#c6a0f6";
		} {
			name = "adb";
			text = "";
			fg = "#8bd5ca";
		} {
			name = "ttf";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "webpack";
			text = "󰜫";
			fg = "#7dc4e4";
		} {
			name = "dart";
			text = "";
			fg = "#5b6078";
		} {
			name = "vsh";
			text = "";
			fg = "#8087a2";
		} {
			name = "doc";
			text = "󰈬";
			fg = "#5b6078";
		} {
			name = "zsh";
			text = "";
			fg = "#a6da95";
		} {
			name = "ex";
			text = "";
			fg = "#8087a2";
		} {
			name = "hx";
			text = "";
			fg = "#f5a97f";
		} {
			name = "fodt";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "mojo";
			text = "";
			fg = "#f5a97f";
		} {
			name = "templ";
			text = "";
			fg = "#eed49f";
		} {
			name = "nix";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "cshtml";
			text = "󱦗";
			fg = "#494d64";
		} {
			name = "fish";
			text = "";
			fg = "#5b6078";
		} {
			name = "ply";
			text = "󰆧";
			fg = "#8087a2";
		} {
			name = "sldprt";
			text = "󰻫";
			fg = "#a6da95";
		} {
			name = "gemspec";
			text = "";
			fg = "#181926";
		} {
			name = "mjs";
			text = "";
			fg = "#eed49f";
		} {
			name = "csh";
			text = "";
			fg = "#5b6078";
		} {
			name = "cmake";
			text = "";
			fg = "#cad3f5";
		} {
			name = "fodp";
			text = "";
			fg = "#f5a97f";
		} {
			name = "vi";
			text = "";
			fg = "#eed49f";
		} {
			name = "msf";
			text = "";
			fg = "#8aadf4";
		} {
			name = "blp";
			text = "󰺾";
			fg = "#8aadf4";
		} {
			name = "less";
			text = "";
			fg = "#494d64";
		} {
			name = "sh";
			text = "";
			fg = "#5b6078";
		} {
			name = "odg";
			text = "";
			fg = "#eed49f";
		} {
			name = "mint";
			text = "󰌪";
			fg = "#a6da95";
		} {
			name = "dll";
			text = "";
			fg = "#181926";
		} {
			name = "odf";
			text = "";
			fg = "#ed8796";
		} {
			name = "sqlite3";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "Dockerfile";
			text = "󰡨";
			fg = "#8aadf4";
		} {
			name = "ksh";
			text = "";
			fg = "#5b6078";
		} {
			name = "rmd";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "wv";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "xml";
			text = "󰗀";
			fg = "#f5a97f";
		} {
			name = "markdown";
			text = "";
			fg = "#cad3f5";
		} {
			name = "qml";
			text = "";
			fg = "#a6da95";
		} {
			name = "3gp";
			text = "";
			fg = "#f5a97f";
		} {
			name = "pxi";
			text = "";
			fg = "#8aadf4";
		} {
			name = "flac";
			text = "";
			fg = "#6e738d";
		} {
			name = "gpr";
			text = "";
			fg = "#c6a0f6";
		} {
			name = "huff";
			text = "󰡘";
			fg = "#494d64";
		} {
			name = "json";
			text = "";
			fg = "#eed49f";
		} {
			name = "gv";
			text = "󱁉";
			fg = "#5b6078";
		} {
			name = "bmp";
			text = "";
			fg = "#8087a2";
		} {
			name = "lock";
			text = "";
			fg = "#b8c0e0";
		} {
			name = "sha384";
			text = "󰕥";
			fg = "#8087a2";
		} {
			name = "cobol";
			text = "⚙";
			fg = "#5b6078";
		} {
			name = "cob";
			text = "⚙";
			fg = "#5b6078";
		} {
			name = "java";
			text = "";
			fg = "#ed8796";
		} {
			name = "cjs";
			text = "";
			fg = "#eed49f";
		} {
			name = "qm";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "ebuild";
			text = "";
			fg = "#494d64";
		} {
			name = "mustache";
			text = "";
			fg = "#f5a97f";
		} {
			name = "terminal";
			text = "";
			fg = "#a6da95";
		} {
			name = "ejs";
			text = "";
			fg = "#eed49f";
		} {
			name = "brep";
			text = "󰻫";
			fg = "#a6da95";
		} {
			name = "rar";
			text = "";
			fg = "#eed49f";
		} {
			name = "gradle";
			text = "";
			fg = "#5b6078";
		} {
			name = "gnumakefile";
			text = "";
			fg = "#8087a2";
		} {
			name = "applescript";
			text = "";
			fg = "#8087a2";
		} {
			name = "elm";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "ebook";
			text = "";
			fg = "#f5a97f";
		} {
			name = "kra";
			text = "";
			fg = "#c6a0f6";
		} {
			name = "tf";
			text = "";
			fg = "#5b6078";
		} {
			name = "xls";
			text = "󰈛";
			fg = "#5b6078";
		} {
			name = "fnl";
			text = "";
			fg = "#eed49f";
		} {
			name = "kdbx";
			text = "";
			fg = "#a6da95";
		} {
			name = "kicad_pcb";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "cfg";
			text = "";
			fg = "#8087a2";
		} {
			name = "ape";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "org";
			text = "";
			fg = "#8bd5ca";
		} {
			name = "yml";
			text = "";
			fg = "#8087a2";
		} {
			name = "swift";
			text = "";
			fg = "#f5a97f";
		} {
			name = "eln";
			text = "";
			fg = "#6e738d";
		} {
			name = "sol";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "awk";
			text = "";
			fg = "#5b6078";
		} {
			name = "7z";
			text = "";
			fg = "#eed49f";
		} {
			name = "apl";
			text = "⍝";
			fg = "#f5a97f";
		} {
			name = "epp";
			text = "";
			fg = "#f5a97f";
		} {
			name = "app";
			text = "";
			fg = "#494d64";
		} {
			name = "dot";
			text = "󱁉";
			fg = "#5b6078";
		} {
			name = "kpp";
			text = "";
			fg = "#c6a0f6";
		} {
			name = "eot";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "hpp";
			text = "";
			fg = "#8087a2";
		} {
			name = "spec.tsx";
			text = "";
			fg = "#5b6078";
		} {
			name = "hurl";
			text = "";
			fg = "#ed8796";
		} {
			name = "cxxm";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "c";
			text = "";
			fg = "#8aadf4";
		} {
			name = "fcmacro";
			text = "";
			fg = "#ed8796";
		} {
			name = "sass";
			text = "";
			fg = "#ed8796";
		} {
			name = "yaml";
			text = "";
			fg = "#8087a2";
		} {
			name = "xz";
			text = "";
			fg = "#eed49f";
		} {
			name = "material";
			text = "󰔉";
			fg = "#6e738d";
		} {
			name = "json5";
			text = "";
			fg = "#eed49f";
		} {
			name = "signature";
			text = "λ";
			fg = "#f5a97f";
		} {
			name = "3mf";
			text = "󰆧";
			fg = "#8087a2";
		} {
			name = "jpg";
			text = "";
			fg = "#8087a2";
		} {
			name = "xpi";
			text = "";
			fg = "#f5a97f";
		} {
			name = "fcmat";
			text = "";
			fg = "#ed8796";
		} {
			name = "pot";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "bin";
			text = "";
			fg = "#494d64";
		} {
			name = "xlsx";
			text = "󰈛";
			fg = "#5b6078";
		} {
			name = "aac";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "kicad_sym";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "xcstrings";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "lff";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "xcf";
			text = "";
			fg = "#5b6078";
		} {
			name = "azcli";
			text = "";
			fg = "#6e738d";
		} {
			name = "license";
			text = "";
			fg = "#eed49f";
		} {
			name = "jsonc";
			text = "";
			fg = "#eed49f";
		} {
			name = "xaml";
			text = "󰙳";
			fg = "#494d64";
		} {
			name = "md5";
			text = "󰕥";
			fg = "#8087a2";
		} {
			name = "xm";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "sln";
			text = "";
			fg = "#5b6078";
		} {
			name = "jl";
			text = "";
			fg = "#8087a2";
		} {
			name = "ml";
			text = "";
			fg = "#f5a97f";
		} {
			name = "http";
			text = "";
			fg = "#8aadf4";
		} {
			name = "x";
			text = "";
			fg = "#8aadf4";
		} {
			name = "wvc";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "wrz";
			text = "󰆧";
			fg = "#8087a2";
		} {
			name = "csproj";
			text = "󰪮";
			fg = "#494d64";
		} {
			name = "wrl";
			text = "󰆧";
			fg = "#8087a2";
		} {
			name = "wma";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "woff2";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "woff";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "tscn";
			text = "";
			fg = "#8087a2";
		} {
			name = "webmanifest";
			text = "";
			fg = "#eed49f";
		} {
			name = "webm";
			text = "";
			fg = "#f5a97f";
		} {
			name = "fcbak";
			text = "";
			fg = "#ed8796";
		} {
			name = "log";
			text = "󰌱";
			fg = "#cad3f5";
		} {
			name = "wav";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "wasm";
			text = "";
			fg = "#5b6078";
		} {
			name = "styl";
			text = "";
			fg = "#a6da95";
		} {
			name = "gif";
			text = "";
			fg = "#8087a2";
		} {
			name = "resi";
			text = "";
			fg = "#ed8796";
		} {
			name = "aiff";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "sha256";
			text = "󰕥";
			fg = "#8087a2";
		} {
			name = "igs";
			text = "󰻫";
			fg = "#a6da95";
		} {
			name = "vsix";
			text = "";
			fg = "#5b6078";
		} {
			name = "vim";
			text = "";
			fg = "#a6da95";
		} {
			name = "diff";
			text = "";
			fg = "#494d64";
		} {
			name = "drl";
			text = "";
			fg = "#ee99a0";
		} {
			name = "erl";
			text = "";
			fg = "#6e738d";
		} {
			name = "vhdl";
			text = "󰍛";
			fg = "#a6da95";
		} {
			name = "🔥";
			text = "";
			fg = "#f5a97f";
		} {
			name = "hrl";
			text = "";
			fg = "#6e738d";
		} {
			name = "fsi";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "mm";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "bz";
			text = "";
			fg = "#eed49f";
		} {
			name = "vh";
			text = "󰍛";
			fg = "#a6da95";
		} {
			name = "kdb";
			text = "";
			fg = "#a6da95";
		} {
			name = "gz";
			text = "";
			fg = "#eed49f";
		} {
			name = "cpp";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "ui";
			text = "";
			fg = "#5b6078";
		} {
			name = "txt";
			text = "󰈙";
			fg = "#a6da95";
		} {
			name = "spec.ts";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "ccm";
			text = "";
			fg = "#ed8796";
		} {
			name = "typoscript";
			text = "";
			fg = "#f5a97f";
		} {
			name = "typ";
			text = "";
			fg = "#8bd5ca";
		} {
			name = "txz";
			text = "";
			fg = "#eed49f";
		} {
			name = "test.ts";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "tsx";
			text = "";
			fg = "#5b6078";
		} {
			name = "mk";
			text = "";
			fg = "#8087a2";
		} {
			name = "webp";
			text = "";
			fg = "#8087a2";
		} {
			name = "opus";
			text = "";
			fg = "#6e738d";
		} {
			name = "bicep";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "ts";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "tres";
			text = "";
			fg = "#8087a2";
		} {
			name = "torrent";
			text = "";
			fg = "#8bd5ca";
		} {
			name = "cxx";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "iso";
			text = "";
			fg = "#f0c6c6";
		} {
			name = "ixx";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "hxx";
			text = "";
			fg = "#8087a2";
		} {
			name = "gql";
			text = "";
			fg = "#ed8796";
		} {
			name = "tmux";
			text = "";
			fg = "#a6da95";
		} {
			name = "ini";
			text = "";
			fg = "#8087a2";
		} {
			name = "m3u8";
			text = "󰲹";
			fg = "#ed8796";
		} {
			name = "image";
			text = "";
			fg = "#f0c6c6";
		} {
			name = "tfvars";
			text = "";
			fg = "#5b6078";
		} {
			name = "tex";
			text = "";
			fg = "#494d64";
		} {
			name = "cbl";
			text = "⚙";
			fg = "#5b6078";
		} {
			name = "flc";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "elc";
			text = "";
			fg = "#6e738d";
		} {
			name = "test.tsx";
			text = "";
			fg = "#5b6078";
		} {
			name = "twig";
			text = "";
			fg = "#a6da95";
		} {
			name = "sql";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "test.jsx";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "htm";
			text = "";
			fg = "#f5a97f";
		} {
			name = "gcode";
			text = "󰐫";
			fg = "#6e738d";
		} {
			name = "test.js";
			text = "";
			fg = "#eed49f";
		} {
			name = "ino";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "tcl";
			text = "󰛓";
			fg = "#5b6078";
		} {
			name = "cljs";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "tsconfig";
			text = "";
			fg = "#f5a97f";
		} {
			name = "img";
			text = "";
			fg = "#f0c6c6";
		} {
			name = "t";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "fcstd1";
			text = "";
			fg = "#ed8796";
		} {
			name = "out";
			text = "";
			fg = "#494d64";
		} {
			name = "jsx";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "bash";
			text = "";
			fg = "#a6da95";
		} {
			name = "edn";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "rss";
			text = "";
			fg = "#f5a97f";
		} {
			name = "flf";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "cache";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "sbt";
			text = "";
			fg = "#ed8796";
		} {
			name = "cppm";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "svelte";
			text = "";
			fg = "#f5a97f";
		} {
			name = "mo";
			text = "∞";
			fg = "#8087a2";
		} {
			name = "sv";
			text = "󰍛";
			fg = "#a6da95";
		} {
			name = "ko";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "suo";
			text = "";
			fg = "#5b6078";
		} {
			name = "sldasm";
			text = "󰻫";
			fg = "#a6da95";
		} {
			name = "icalendar";
			text = "";
			fg = "#363a4f";
		} {
			name = "go";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "sublime";
			text = "";
			fg = "#f5a97f";
		} {
			name = "stl";
			text = "󰆧";
			fg = "#8087a2";
		} {
			name = "mobi";
			text = "";
			fg = "#f5a97f";
		} {
			name = "graphql";
			text = "";
			fg = "#ed8796";
		} {
			name = "m3u";
			text = "󰲹";
			fg = "#ed8796";
		} {
			name = "cpy";
			text = "⚙";
			fg = "#5b6078";
		} {
			name = "kdenlive";
			text = "";
			fg = "#8aadf4";
		} {
			name = "pyo";
			text = "";
			fg = "#eed49f";
		} {
			name = "po";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "scala";
			text = "";
			fg = "#ed8796";
		} {
			name = "exs";
			text = "";
			fg = "#8087a2";
		} {
			name = "odp";
			text = "";
			fg = "#f5a97f";
		} {
			name = "dump";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "stp";
			text = "󰻫";
			fg = "#a6da95";
		} {
			name = "step";
			text = "󰻫";
			fg = "#a6da95";
		} {
			name = "ste";
			text = "󰻫";
			fg = "#a6da95";
		} {
			name = "aif";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "strings";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "cp";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "fsscript";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "mli";
			text = "";
			fg = "#f5a97f";
		} {
			name = "bak";
			text = "󰁯";
			fg = "#8087a2";
		} {
			name = "ssa";
			text = "󰨖";
			fg = "#eed49f";
		} {
			name = "toml";
			text = "";
			fg = "#ed8796";
		} {
			name = "makefile";
			text = "";
			fg = "#8087a2";
		} {
			name = "php";
			text = "";
			fg = "#8087a2";
		} {
			name = "zst";
			text = "";
			fg = "#eed49f";
		} {
			name = "spec.jsx";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "kbx";
			text = "󰯄";
			fg = "#6e738d";
		} {
			name = "fbx";
			text = "󰆧";
			fg = "#8087a2";
		} {
			name = "blend";
			text = "󰂫";
			fg = "#f5a97f";
		} {
			name = "ifc";
			text = "󰻫";
			fg = "#a6da95";
		} {
			name = "spec.js";
			text = "";
			fg = "#eed49f";
		} {
			name = "so";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "desktop";
			text = "";
			fg = "#494d64";
		} {
			name = "sml";
			text = "λ";
			fg = "#f5a97f";
		} {
			name = "slvs";
			text = "󰻫";
			fg = "#a6da95";
		} {
			name = "pp";
			text = "";
			fg = "#f5a97f";
		} {
			name = "ps1";
			text = "󰨊";
			fg = "#6e738d";
		} {
			name = "dropbox";
			text = "";
			fg = "#6e738d";
		} {
			name = "kicad_mod";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "bat";
			text = "";
			fg = "#a6da95";
		} {
			name = "slim";
			text = "";
			fg = "#f5a97f";
		} {
			name = "skp";
			text = "󰻫";
			fg = "#a6da95";
		} {
			name = "css";
			text = "";
			fg = "#8aadf4";
		} {
			name = "xul";
			text = "";
			fg = "#f5a97f";
		} {
			name = "ige";
			text = "󰻫";
			fg = "#a6da95";
		} {
			name = "glb";
			text = "";
			fg = "#f5a97f";
		} {
			name = "ppt";
			text = "󰈧";
			fg = "#ed8796";
		} {
			name = "sha512";
			text = "󰕥";
			fg = "#8087a2";
		} {
			name = "ics";
			text = "";
			fg = "#363a4f";
		} {
			name = "mdx";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "sha1";
			text = "󰕥";
			fg = "#8087a2";
		} {
			name = "f3d";
			text = "󰻫";
			fg = "#a6da95";
		} {
			name = "ass";
			text = "󰨖";
			fg = "#eed49f";
		} {
			name = "godot";
			text = "";
			fg = "#8087a2";
		} {
			name = "ifb";
			text = "";
			fg = "#363a4f";
		} {
			name = "cson";
			text = "";
			fg = "#eed49f";
		} {
			name = "lib";
			text = "";
			fg = "#181926";
		} {
			name = "luac";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "heex";
			text = "";
			fg = "#8087a2";
		} {
			name = "scm";
			text = "󰘧";
			fg = "#f4dbd6";
		} {
			name = "psd1";
			text = "󰨊";
			fg = "#6e738d";
		} {
			name = "sc";
			text = "";
			fg = "#ed8796";
		} {
			name = "scad";
			text = "";
			fg = "#eed49f";
		} {
			name = "kts";
			text = "";
			fg = "#6e738d";
		} {
			name = "svh";
			text = "󰍛";
			fg = "#a6da95";
		} {
			name = "mts";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "nfo";
			text = "";
			fg = "#eed49f";
		} {
			name = "pck";
			text = "";
			fg = "#8087a2";
		} {
			name = "rproj";
			text = "󰗆";
			fg = "#a6da95";
		} {
			name = "rlib";
			text = "";
			fg = "#f5a97f";
		} {
			name = "cljd";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "ods";
			text = "";
			fg = "#a6da95";
		} {
			name = "res";
			text = "";
			fg = "#ed8796";
		} {
			name = "apk";
			text = "";
			fg = "#a6da95";
		} {
			name = "haml";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "d.ts";
			text = "";
			fg = "#f5a97f";
		} {
			name = "razor";
			text = "󱦘";
			fg = "#494d64";
		} {
			name = "rake";
			text = "";
			fg = "#181926";
		} {
			name = "patch";
			text = "";
			fg = "#494d64";
		} {
			name = "cuh";
			text = "";
			fg = "#8087a2";
		} {
			name = "d";
			text = "";
			fg = "#ed8796";
		} {
			name = "query";
			text = "";
			fg = "#a6da95";
		} {
			name = "psb";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "nu";
			text = ">";
			fg = "#a6da95";
		} {
			name = "mov";
			text = "";
			fg = "#f5a97f";
		} {
			name = "lrc";
			text = "󰨖";
			fg = "#eed49f";
		} {
			name = "pyx";
			text = "";
			fg = "#8aadf4";
		} {
			name = "pyw";
			text = "";
			fg = "#8aadf4";
		} {
			name = "cu";
			text = "";
			fg = "#a6da95";
		} {
			name = "bazel";
			text = "";
			fg = "#a6da95";
		} {
			name = "obj";
			text = "󰆧";
			fg = "#8087a2";
		} {
			name = "pyi";
			text = "";
			fg = "#eed49f";
		} {
			name = "pyd";
			text = "";
			fg = "#eed49f";
		} {
			name = "exe";
			text = "";
			fg = "#494d64";
		} {
			name = "pyc";
			text = "";
			fg = "#eed49f";
		} {
			name = "fctb";
			text = "";
			fg = "#ed8796";
		} {
			name = "part";
			text = "";
			fg = "#8bd5ca";
		} {
			name = "blade.php";
			text = "";
			fg = "#ed8796";
		} {
			name = "git";
			text = "";
			fg = "#f5a97f";
		} {
			name = "psd";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "qss";
			text = "";
			fg = "#a6da95";
		} {
			name = "csv";
			text = "";
			fg = "#a6da95";
		} {
			name = "psm1";
			text = "󰨊";
			fg = "#6e738d";
		} {
			name = "dconf";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "config.ru";
			text = "";
			fg = "#181926";
		} {
			name = "prisma";
			text = "";
			fg = "#6e738d";
		} {
			name = "conf";
			text = "";
			fg = "#8087a2";
		} {
			name = "clj";
			text = "";
			fg = "#a6da95";
		} {
			name = "o";
			text = "";
			fg = "#494d64";
		} {
			name = "mp4";
			text = "";
			fg = "#f5a97f";
		} {
			name = "cc";
			text = "";
			fg = "#ed8796";
		} {
			name = "kicad_prl";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "bz3";
			text = "";
			fg = "#eed49f";
		} {
			name = "asc";
			text = "󰦝";
			fg = "#5b6078";
		} {
			name = "png";
			text = "";
			fg = "#8087a2";
		} {
			name = "android";
			text = "";
			fg = "#a6da95";
		} {
			name = "pm";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "h";
			text = "";
			fg = "#8087a2";
		} {
			name = "pls";
			text = "󰲹";
			fg = "#ed8796";
		} {
			name = "ipynb";
			text = "";
			fg = "#f5a97f";
		} {
			name = "pl";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "ads";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "sqlite";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "pdf";
			text = "";
			fg = "#ed8796";
		} {
			name = "pcm";
			text = "";
			fg = "#6e738d";
		} {
			name = "ico";
			text = "";
			fg = "#eed49f";
		} {
			name = "a";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "R";
			text = "󰟔";
			fg = "#5b6078";
		} {
			name = "ogg";
			text = "";
			fg = "#6e738d";
		} {
			name = "pxd";
			text = "";
			fg = "#8aadf4";
		} {
			name = "kdenlivetitle";
			text = "";
			fg = "#8aadf4";
		} {
			name = "jxl";
			text = "";
			fg = "#8087a2";
		} {
			name = "nswag";
			text = "";
			fg = "#a6da95";
		} {
			name = "nim";
			text = "";
			fg = "#eed49f";
		} {
			name = "bqn";
			text = "⎉";
			fg = "#5b6078";
		} {
			name = "cts";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "fcparam";
			text = "";
			fg = "#ed8796";
		} {
			name = "rs";
			text = "";
			fg = "#f5a97f";
		} {
			name = "mpp";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "fdmdownload";
			text = "";
			fg = "#8bd5ca";
		} {
			name = "pptx";
			text = "󰈧";
			fg = "#ed8796";
		} {
			name = "jpeg";
			text = "";
			fg = "#8087a2";
		} {
			name = "bib";
			text = "󱉟";
			fg = "#eed49f";
		} {
			name = "vhd";
			text = "󰍛";
			fg = "#a6da95";
		} {
			name = "m";
			text = "";
			fg = "#8aadf4";
		} {
			name = "js";
			text = "";
			fg = "#eed49f";
		} {
			name = "eex";
			text = "";
			fg = "#8087a2";
		} {
			name = "tbc";
			text = "󰛓";
			fg = "#5b6078";
		} {
			name = "astro";
			text = "";
			fg = "#ed8796";
		} {
			name = "sha224";
			text = "󰕥";
			fg = "#8087a2";
		} {
			name = "xcplayground";
			text = "";
			fg = "#f5a97f";
		} {
			name = "el";
			text = "";
			fg = "#6e738d";
		} {
			name = "m4v";
			text = "";
			fg = "#f5a97f";
		} {
			name = "m4a";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "cs";
			text = "󰌛";
			fg = "#a6da95";
		} {
			name = "hs";
			text = "";
			fg = "#8087a2";
		} {
			name = "tgz";
			text = "";
			fg = "#eed49f";
		} {
			name = "fs";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "luau";
			text = "";
			fg = "#8aadf4";
		} {
			name = "dxf";
			text = "󰻫";
			fg = "#a6da95";
		} {
			name = "download";
			text = "";
			fg = "#8bd5ca";
		} {
			name = "cast";
			text = "";
			fg = "#f5a97f";
		} {
			name = "qrc";
			text = "";
			fg = "#a6da95";
		} {
			name = "lua";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "lhs";
			text = "";
			fg = "#8087a2";
		} {
			name = "md";
			text = "";
			fg = "#cad3f5";
		} {
			name = "leex";
			text = "";
			fg = "#8087a2";
		} {
			name = "ai";
			text = "";
			fg = "#eed49f";
		} {
			name = "lck";
			text = "";
			fg = "#b8c0e0";
		} {
			name = "kt";
			text = "";
			fg = "#6e738d";
		} {
			name = "bicepparam";
			text = "";
			fg = "#8087a2";
		} {
			name = "hex";
			text = "";
			fg = "#6e738d";
		} {
			name = "zig";
			text = "";
			fg = "#f5a97f";
		} {
			name = "bzl";
			text = "";
			fg = "#a6da95";
		} {
			name = "cljc";
			text = "";
			fg = "#a6da95";
		} {
			name = "kicad_dru";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "fctl";
			text = "";
			fg = "#ed8796";
		} {
			name = "f#";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "odt";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "conda";
			text = "";
			fg = "#a6da95";
		} {
			name = "vala";
			text = "";
			fg = "#5b6078";
		} {
			name = "erb";
			text = "";
			fg = "#181926";
		} {
			name = "mp3";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "bz2";
			text = "";
			fg = "#eed49f";
		} {
			name = "coffee";
			text = "";
			fg = "#eed49f";
		} {
			name = "cr";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "f90";
			text = "󱈚";
			fg = "#5b6078";
		} {
			name = "jwmrc";
			text = "";
			fg = "#6e738d";
		} {
			name = "c++";
			text = "";
			fg = "#ed8796";
		} {
			name = "fcscript";
			text = "";
			fg = "#ed8796";
		} {
			name = "fods";
			text = "";
			fg = "#a6da95";
		} {
			name = "cue";
			text = "󰲹";
			fg = "#ed8796";
		} {
			name = "srt";
			text = "󰨖";
			fg = "#eed49f";
		} {
			name = "info";
			text = "";
			fg = "#eed49f";
		} {
			name = "hh";
			text = "";
			fg = "#8087a2";
		} {
			name = "sig";
			text = "λ";
			fg = "#f5a97f";
		} {
			name = "html";
			text = "";
			fg = "#f5a97f";
		} {
			name = "iges";
			text = "󰻫";
			fg = "#a6da95";
		} {
			name = "kicad_wks";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "hbs";
			text = "";
			fg = "#f5a97f";
		} {
			name = "fcstd";
			text = "";
			fg = "#ed8796";
		} {
			name = "gresource";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "sub";
			text = "󰨖";
			fg = "#eed49f";
		} {
			name = "ical";
			text = "";
			fg = "#363a4f";
		} {
			name = "crdownload";
			text = "";
			fg = "#8bd5ca";
		} {
			name = "pub";
			text = "󰷖";
			fg = "#eed49f";
		} {
			name = "vue";
			text = "";
			fg = "#a6da95";
		} {
			name = "gd";
			text = "";
			fg = "#8087a2";
		} {
			name = "fsx";
			text = "";
			fg = "#7dc4e4";
		} {
			name = "mkv";
			text = "";
			fg = "#f5a97f";
		} {
			name = "py";
			text = "";
			fg = "#eed49f";
		} {
			name = "kicad_sch";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "epub";
			text = "";
			fg = "#f5a97f";
		} {
			name = "env";
			text = "";
			fg = "#eed49f";
		} {
			name = "magnet";
			text = "";
			fg = "#494d64";
		} {
			name = "elf";
			text = "";
			fg = "#494d64";
		} {
			name = "fodg";
			text = "";
			fg = "#eed49f";
		} {
			name = "svg";
			text = "󰜡";
			fg = "#f5a97f";
		} {
			name = "dwg";
			text = "󰻫";
			fg = "#a6da95";
		} {
			name = "docx";
			text = "󰈬";
			fg = "#5b6078";
		} {
			name = "pro";
			text = "";
			fg = "#eed49f";
		} {
			name = "db";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "rb";
			text = "";
			fg = "#181926";
		} {
			name = "r";
			text = "󰟔";
			fg = "#5b6078";
		} {
			name = "scss";
			text = "";
			fg = "#ed8796";
		} {
			name = "cow";
			text = "󰆚";
			fg = "#f5a97f";
		} {
			name = "gleam";
			text = "";
			fg = "#f5bde6";
		} {
			name = "v";
			text = "󰍛";
			fg = "#a6da95";
		} {
			name = "kicad_pro";
			text = "";
			fg = "#f4dbd6";
		} {
			name = "liquid";
			text = "";
			fg = "#a6da95";
		} {
			name = "zip";
			text = "";
			fg = "#eed49f";
		} ];
	};
}