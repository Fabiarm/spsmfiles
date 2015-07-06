using System;
using System.Runtime.InteropServices;
using System.Security.Permissions;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Security;

namespace SP2010.Manage.FileTypes.Features.SPManageFileTypeFeature
{
    /// <summary>
    /// This class handles events raised during feature activation, deactivation, installation, uninstallation, and upgrade.
    /// </summary>
    /// <remarks>
    /// The GUID attached to this class may be used during packaging and should not be modified.
    /// </remarks>

    [Guid("04a40a8a-66c8-4eec-988d-74bddf9df253")]
    public class SPManageFileTypeFeatureEventReceiver : SPFeatureReceiver
    {
        // Uncomment the method below to handle the event raised after a feature has been activated.

        public override void FeatureActivated(SPFeatureReceiverProperties properties)
        {
            SPSite site = (SPSite)properties.Feature.Parent;
            using (SPWeb rootWeb = site.OpenWeb())
            {
                SPFeatureProperty types = properties.Feature.Properties[Content.SPFileTypes];
                SPFeatureProperty sizes = properties.Feature.Properties[Content.SPFileSizes];
                SPFeatureProperty actives = properties.Feature.Properties[Content.SPFileTypesActive];
                Helper.AddOrUpdateBagProperty(rootWeb, types.Name, types.Value);
                Helper.AddOrUpdateBagProperty(rootWeb, sizes.Name, sizes.Value);
                Helper.AddOrUpdateBagProperty(rootWeb, actives.Name, actives.Value);
            }
        }



        // Uncomment the method below to handle the event raised before a feature is deactivated.

        public override void FeatureDeactivating(SPFeatureReceiverProperties properties)
        {
            SPSite site = (SPSite)properties.Feature.Parent;
            using (SPWeb rootWeb = site.OpenWeb())
            {
                SPFeatureProperty types = properties.Feature.Properties[Content.SPFileTypes];
                SPFeatureProperty sizes = properties.Feature.Properties[Content.SPFileSizes];
                SPFeatureProperty actives = properties.Feature.Properties[Content.SPFileTypesActive];
                Helper.RemoveBagProperty(rootWeb, types.Name);
                Helper.RemoveBagProperty(rootWeb, sizes.Name);
                Helper.RemoveBagProperty(rootWeb, actives.Name);
            }
        }


        // Uncomment the method below to handle the event raised after a feature has been installed.

        //public override void FeatureInstalled(SPFeatureReceiverProperties properties)
        //{
        //}


        // Uncomment the method below to handle the event raised before a feature is uninstalled.

        //public override void FeatureUninstalling(SPFeatureReceiverProperties properties)
        //{
        //}

        // Uncomment the method below to handle the event raised when a feature is upgrading.

        //public override void FeatureUpgrading(SPFeatureReceiverProperties properties, string upgradeActionName, System.Collections.Generic.IDictionary<string, string> parameters)
        //{
        //}
    }
}
