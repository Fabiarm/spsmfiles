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
    <link rel="stylesheet" type="text/css" href="/_layouts/15/SPS.MFiles/CSS/MFiles.css" />
    <script type="text/javascript" src="/_layouts/15/SPS.MFiles/JS/jquery.min.js"></script>
    <SharePoint:ScriptLink ID="ScriptLink1" Name="SP.js" runat="server" OnDemand="true" LoadAfterUI="true" Localizable="false" />
    <script type="text/javascript" src="/_layouts/15/sp.init.js"></script>
    <script type="text/javascript" src="/_layouts/15/ScriptResx.ashx?culture=<SharePoint:EncodedLiteral runat='server' text='<%$Resources:wss,language_value%>' EncodeMethod='HtmlEncode' />&name=SPS.MFiles"></script>
    <script type="text/ecmascript" src="/_layouts/15/SP.UI.Dialog.js"></script>
    <script type="text/javascript" src="/_layouts/15/SPS.MFiles/JS/MFiles.js"></script>
    <script type="text/ecmascript" src="/_layouts/15/SPS.MFiles/JS/MFilesEcma.js"></script>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <SharePoint:FormDigest ID="digest" runat="server"></SharePoint:FormDigest>
    <div id="divTab">
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
                                            <asp:RegularExpressionValidator ID="vldRegExtension" runat="server" ControlToValidate="txtExtension" CssClass="ms-formvalidation"
                                                EnableClientScript="true" SetFocusOnError="true" ValidationExpression="\.\w+"
                                                ErrorMessage="<%$Resources:SPS.MFiles,SettingPage_Validator_RegExtension%>"
                                                Display="Dynamic"></asp:RegularExpressionValidator>
                                            <asp:RequiredFieldValidator ID="vldReqExtension" runat="server" ControlToValidate="txtExtension" CssClass="ms-formvalidation"
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
                                            <asp:RequiredFieldValidator ID="vldReqSize" runat="server" ControlToValidate="txtSize" CssClass="ms-formvalidation"
                                                EnableClientScript="true" SetFocusOnError="true" ErrorMessage="<%$Resources:SPS.MFiles,SettingPage_Validator_ReqSize%>"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:RangeValidator ControlToValidate="txtSize" ErrorMessage="vldRangeSize" ID="vldRangeSize" CssClass="ms-formvalidation"
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
                            <a id="imgDivLink" style="cursor:pointer;vertical-align:middle;" onclick="javascript:AddNewExtension();">
                                <span class="btn">
                                    <img alt="" class="small-add-ext" src="/_layouts/15/images/SPS.MFiles/formatmap16x16.png"/>&nbsp;
                                </span>
                                <SharePoint:EncodedLiteral ID="ltlAddNew" runat="server" Text="<%$Resources:SPS.MFiles,SettingPage_AddNewType%>" EncodeMethod='HtmlEncode' />
                               </a>
                            <asp:Button ID="btnSaveSettings" runat="server" Text="<%$Resources:SPS.MFiles,SettingPage_SaveSettings%>"
                                CssClass="ms-ButtonHeightWidth" Enabled="true" OnClick="btnSaveSettings_Click"/>
                        </template_inputformcontrols>
                        </wssuc:InputFormSection>
                    </table>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
    <SharePoint:EncodedLiteral ID="ltlPageTitle" runat="server" Text="<%$Resources:SPS.MFiles,SettingPage_PageTitle%>" EncodeMethod='HtmlEncode' />
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server">
    <SharePoint:EncodedLiteral ID="ltlPageTitleInTitleArea" runat="server" Text="<%$Resources:SPS.MFiles,SettingPage_PageTitleInTitleArea%>" EncodeMethod='HtmlEncode' />
</asp:Content>
