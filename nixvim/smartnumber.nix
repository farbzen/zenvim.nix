{lib, ...}: let
  excludedFiletypes = lib.nixvim.toLuaObject [
    "snacks_picker_list"
    "snacks_terminal"
    "neo-tree"
    "neo-tree-popup"
  ];

  setRelativeNumber = expression: ''
    if not vim.tbl_contains(${excludedFiletypes}, vim.o.filetype) then
      vim.wo.relativenumber = ${expression}
    end
  '';

  relativeUnlessInsert = ''(vim.fn.mode() ~= "i")'';

  mkSmartnumberAutoCmd = event: body: {
    inherit event;
    group = "smartnumber";
    callback = lib.nixvim.mkRaw ''
      function()
        ${body}
      end
    '';
  };
in {
  autoGroups.smartnumber.clear = true;

  extraConfigLua = setRelativeNumber relativeUnlessInsert;

  autoCmd = [
    (mkSmartnumberAutoCmd "InsertEnter" (setRelativeNumber "false"))
    (mkSmartnumberAutoCmd "InsertLeave" (setRelativeNumber "true"))
    (mkSmartnumberAutoCmd "CmdlineEnter" ''
      if not vim.tbl_contains(${excludedFiletypes}, vim.o.filetype) then
        vim.wo.relativenumber = false
        vim.cmd("redraw")
      end
    '')
    (mkSmartnumberAutoCmd "CmdlineLeave" (setRelativeNumber "true"))
    (mkSmartnumberAutoCmd "WinEnter" (setRelativeNumber relativeUnlessInsert))
    (mkSmartnumberAutoCmd "WinLeave" (setRelativeNumber "false"))
    (mkSmartnumberAutoCmd "FocusGained" (setRelativeNumber relativeUnlessInsert))
    (mkSmartnumberAutoCmd "FocusLost" (setRelativeNumber "false"))
  ];
}
