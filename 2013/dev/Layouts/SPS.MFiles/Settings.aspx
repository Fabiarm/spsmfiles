<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Register TagPrefix="wssuc" TagName="InputFormControl" Src="~/_controltemplates/InputFormControl.ascx" %>
<%@ Register TagPrefix="wssuc" TagName="InputFormSection" Src="~/_controltemplates/InputFormSection.ascx" %>
<%@ Register TagPrefix="wssuc" TagName="ButtonSection" Src="~/_controltemplates/ButtonSection.ascx" %>
<%@ Import Namespace="SPS.MFiles.Common" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="SPS.MFiles.Layouts.SPS.MFiles.Settings" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <SharePoint:ScriptLink ID="ScriptLink1" Name="SP.js" runat="server" OnDemand="true" LoadAfterUI="true" Localizable="false" />
    <script type="text/javascript" src="/_layouts/15/sp.init.js"></script>
    <script type="text/javascript" src="/_layouts/15/ScriptResx.ashx?culture=<SharePoint:EncodedLiteral runat='server' text='<%$Resources:wss,language_value%>' EncodeMethod='HtmlEncode' />&name=SPS.MFiles"></script>
    <script type="text/ecmascript" src="/_layouts/15/SP.UI.Dialog.js"></script>
    <style type="text/css">
        .ms-image {
            border: 0px none transparent;
        }

        .ms-descriptiontext {
            min-width: 450px;
            width: 450px !important;
        }

        .ms-tableRow td.ms-formlabel, .ms-tableRow td.ms-formbody {
            border-bottom: 1px solid #d8d8d8;
            border-top: 1px solid #d8d8d8;
            border-right: 1px solid #d8d8d8;
        }

        .ms-tableRow td.ms-formbody-new {
            border: 0px none;
            padding: 2px;
        }

        .ms-tableRow td.ms-formbody {
            vertical-align: top;
        }

        .ms-viewheadertr th.ms-vh2-gridview {
            background-color: transparent;
        }

        .ms-input {
            float: left;
            margin: 3px;
        }

        .ms-div {
            overflow: auto;
            border: none;
            width: 99%;
            border: none;
            margin-left: 5px;
            margin-right: 5px;
        }

        .ms-ButtonHeightWidth {
            float: right;
            margin: 5px 0px 5px 5px;
        }
    </style>
    <script type="text/javascript">
        function bytesToSize(control) {
            var bytes = control.value;
            var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
            if (bytes == 0) return 'n/a';
            var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
            var divControl = document.getElementById(control.id + '_span');
            control.title = Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
            divControl.innerHTML = Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
        }
    </script>
    <script type="text/ecmascript">
        function AddNewExtension() {
            SP.SOD.executeFunc('sp.js', 'SP.ClientContext', function () {
                var options = {
                    url: SP.Utilities.Utility.getLayoutsPageUrl('SPS.MFiles/AddNewExtension.aspx'),
                    title: Res.settingPage_AddNewType,
                    allowMaximize: false,
                    autoSize: false,
                    height: 150,
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
    </script>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <SharePoint:FormDigest ID="digest" runat="server"></SharePoint:FormDigest>
    <asp:UpdatePanel runat="server" ID="updSettings">
        <ContentTemplate>
            <asp:HiddenField ID="hdnSuccess" runat="server" Value="<%$Resources:SPS.MFiles,SettingPage_Success%>" />
            <asp:HiddenField ID="hdnFailed" runat="server" Value="<%$Resources:SPS.MFiles,SettingPage_Failed%>" />
            <asp:HiddenField ID="hdnIsExists" runat="server" Value="<%$Resources:SPS.MFiles,SettingPage_IsExists%>" />
            <div class="ms-div">
                <table cellpadding="0" width="100%" cellspacing="0" border="0">
                    <wssuc:InputFormSection ID="InputFormSection1" Collapsible="false" runat="server">
                        <template_title>
                            <SharePoint:EncodedLiteral ID="ltlTitle" runat="server" Text="<%$Resources:SPS.MFiles,SettingPage_TemplateTitle%>" EncodeMethod='HtmlEncode' />
                        </template_title>
                        <template_description>
                            <SharePoint:EncodedLiteral ID="ltlTemplateDescription" Text="<%$Resources:SPS.MFiles,SettingPage_TemplateDescription %>" runat="server" EncodeMethod='HtmlEncode' />
                        </template_description>
                        <template_inputformcontrols>
                            <SharePoint:SPGridView runat="server" CellPadding="0" CellSpacing="0" ID="spgvSettings"
                                AlternatingRowStyle-CssClass="ms-tableRow" OnRowDataBound="spgvSettings_RowDataBound"
                                RowStyle-CssClass="ms-tableRow" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:TemplateField ItemStyle-Width="40px" ItemStyle-CssClass="ms-formbody" ItemStyle-VerticalAlign="Top"
                                        ItemStyle-HorizontalAlign="Center" ShowHeader="true" HeaderText="<%$Resources:SPS.MFiles,SettingPage_FileType%>">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtExtension" runat="server" Enabled="true" Width="90%" CssClass="ms-input"
                                                Text='<%# Eval("Extension") %>'></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="vldRegExtension" runat="server" ControlToValidate="txtExtension"
                                                EnableClientScript="true" SetFocusOnError="true" ValidationExpression="\.\w+"
                                                ErrorMessage="<%$Resources:SPS.MFiles,SettingPage_Validator_RegExtension%>"
                                                Display="Dynamic"></asp:RegularExpressionValidator>
                                            <asp:RequiredFieldValidator ID="vldReqExtension" runat="server" ControlToValidate="txtExtension"
                                                EnableClientScript="true" SetFocusOnError="true" ErrorMessage="<%$Resources:SPS.MFiles,SettingPage_Validator_ReqExtension%>"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="40px" ItemStyle-CssClass="ms-formbody" ItemStyle-VerticalAlign="Top"
                                        ItemStyle-HorizontalAlign="Center" ShowHeader="true" HeaderStyle-Wrap="false"
                                        HeaderText="<%$Resources:SPS.MFiles,SettingPage_MaxSize%>">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtSize" runat="server" Width="90%" onchange="javascript:bytesToSize(this);"
                                                ToolTip="" CssClass="ms-input" Text='<%# Eval("Size") %>'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="vldReqSize" runat="server" ControlToValidate="txtSize"
                                                EnableClientScript="true" SetFocusOnError="true" ErrorMessage="<%$Resources:SPS.MFiles,SettingPage_Validator_ReqSize%>"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:RangeValidator ControlToValidate="txtSize" ErrorMessage="vldRangeSize" ID="vldRangeSize"
                                                EnableClientScript="true" SetFocusOnError="true" MaximumValue="99999999" MinimumValue="1"
                                                runat="server" Type="Integer" Display="Dynamic">
                                                <SharePoint:EncodedLiteral ID="ltlValRangeSize" runat="server" Text="<%$Resources:SPS.MFiles,SettingPage_Validator_RangeSize%>"
                                                    EncodeMethod='HtmlEncode' /></asp:RangeValidator>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField ItemStyle-Width="20px" ItemStyle-CssClass="ms-formbody" ItemStyle-VerticalAlign="Top"
                                        ItemStyle-HorizontalAlign="Center" ShowHeader="true" HeaderText="<%$Resources:SPS.MFiles,SettingPage_Active%>">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chbActive" runat="server" AutoPostBack="false" Text="" Checked="false" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="20px" ItemStyle-CssClass="ms-formbody" ItemStyle-VerticalAlign="Top"
                                        ItemStyle-HorizontalAlign="Center" ShowHeader="true" HeaderText="<%$Resources:SPS.MFiles,SettingPage_Delete%>">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chbDelete" runat="server" AutoPostBack="false" Text="" Checked="false" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <SharePoint:EncodedLiteral ID="ltlGridNoItems" runat="server" Text="<%$Resources:SPS.MFiles,SettingPage_Grid_NoItems%>"
                                        EncodeMethod='HtmlEncode' />
                                </EmptyDataTemplate>
                                <FooterStyle CssClass="ms-formline" />
                            </SharePoint:SPGridView>
                            <a id="imgDivLink" style="cursor:pointer;" onclick="javascript:AddNewExtension();">
                                <SharePoint:EncodedLiteral ID="ltlAddNew" runat="server" Text="<%$Resources:SPS.MFiles,SettingPage_AddNewType%>" EncodeMethod='HtmlEncode' /></a>
                            <asp:Button ID="btnSaveSettings" runat="server" Text="<%$Resources:SPS.MFiles,SettingPage_SaveSettings%>"
                                CssClass="ms-ButtonHeightWidth" Enabled="true" OnClick="btnSaveSettings_Click"/>
                        </template_inputformcontrols>
                    </wssuc:InputFormSection>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
    <SharePoint:EncodedLiteral ID="ltlPageTitle" runat="server" Text="<%$Resources:SPS.MFiles,SettingPage_PageTitle%>" EncodeMethod='HtmlEncode' />
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server">
    <SharePoint:EncodedLiteral ID="ltlPageTitleInTitleArea" runat="server" Text="<%$Resources:SPS.MFiles,SettingPage_PageTitleInTitleArea%>" EncodeMethod='HtmlEncode' />
</asp:Content>
