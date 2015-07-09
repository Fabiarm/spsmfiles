SP.SOD.executeFunc('sp.js', 'SP.ClientContext', CheckPermissions);
///<summary>Check matrix of permissions for current user</summary>
function CheckPermissions() {
    $("#divTab").hide();
    var ctx = new SP.ClientContext.get_current();
    var cWeb = ctx.get_web();
    var ob = new SP.BasePermissions();
    ob.set(SP.PermissionKind.manageWeb)
    ob.set(SP.PermissionKind.managePermissions)
    var per = cWeb.doesUserHavePermissions(ob)
    ctx.executeQueryAsync(
         function () {
             if (per.get_value() == true) {
                 $("#divTab").show();
             }
             else {
                 $("#divTab").hide();
                 SP.UI.Status.removeAllStatus(true);
                 var status = SP.UI.Status.addStatus(Res.ss_Msg_AccessDenied_Title, Res.ss_Msg_AccessDenied);
                 SP.UI.Status.setStatusPriColor(status, 'red');
             }
         },
         null
    );
}
function AddNewExtension() {
    SP.SOD.executeFunc('sp.js', 'SP.ClientContext', function () {
        var options = {
            url: SP.Utilities.Utility.getLayoutsPageUrl('SPS.MFiles/AddNewExtension.aspx'),
            title: Res.settingPage_AddNewType,
            allowMaximize: false,
            autoSize: false,
            height: 200,
            width: 500,
            showClose: true,
            dialogReturnValueCallback: function (dialogResult) {
                SP.UI.ModalDialog.RefreshPage(dialogResult)
            }
        };
        SP.SOD.execute('sp.ui.dialog.js', 'SP.UI.ModalDialog.showModalDialog', options);
        return false;
    });
}