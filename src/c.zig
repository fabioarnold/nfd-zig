pub const nfdchar_t = u8;
const struct_unnamed_1 = extern struct {
    buf: [*c]nfdchar_t,
    indices: [*c]usize,
    count: usize,
};
pub const nfdpathset_t = struct_unnamed_1;
pub const NFD_ERROR = @enumToInt(enum_unnamed_2.NFD_ERROR);
pub const NFD_OKAY = @enumToInt(enum_unnamed_2.NFD_OKAY);
pub const NFD_CANCEL = @enumToInt(enum_unnamed_2.NFD_CANCEL);
const enum_unnamed_2 = extern enum(c_int) {
    NFD_ERROR,
    NFD_OKAY,
    NFD_CANCEL,
    _,
};
pub const nfdresult_t = enum_unnamed_2;
pub extern fn NFD_OpenDialog(filterList: [*c]const nfdchar_t, defaultPath: [*c]const nfdchar_t, outPath: [*c][*c]nfdchar_t) nfdresult_t;
pub extern fn NFD_OpenDialogMultiple(filterList: [*c]const nfdchar_t, defaultPath: [*c]const nfdchar_t, outPaths: [*c]nfdpathset_t) nfdresult_t;
pub extern fn NFD_SaveDialog(filterList: [*c]const nfdchar_t, defaultPath: [*c]const nfdchar_t, outPath: [*c][*c]nfdchar_t) nfdresult_t;
pub extern fn NFD_PickFolder(defaultPath: [*c]const nfdchar_t, outPath: [*c][*c]nfdchar_t) nfdresult_t;
pub extern fn NFD_GetError() [*c]const u8;
pub extern fn NFD_PathSet_GetCount(pathSet: [*c]const nfdpathset_t) usize;
pub extern fn NFD_PathSet_GetPath(pathSet: [*c]const nfdpathset_t, index: usize) [*c]nfdchar_t;
pub extern fn NFD_PathSet_Free(pathSet: [*c]nfdpathset_t) void;