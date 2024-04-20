{
  programs.nixvim.plugins = {
    mini = {
      enable = true;
      modules = {
        /*
        Better around/inside textobjects, for example:
        	- va)  - [V]isually select [A]round [)]paren
        	- yinq - [Y]ank [I]nside [N]ext [']quote
        	- ci'  - [C]hange [I]nside [']quote
        */
        ai = {
          n_lines = 50;
          search_method = "cover_or_next";
        };
        /*
        Add/delete/replace surroundings (brackets, quotes, etc.)
                - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        	- sd'   - [S]urround [D]elete [']quotes
        	- sr)'  - [S]urround [R]eplace [)] [']
        */
        surround = {};
      };
    };
  };
}
