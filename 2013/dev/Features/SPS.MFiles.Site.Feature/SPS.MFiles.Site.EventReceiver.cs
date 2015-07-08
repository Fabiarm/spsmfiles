using System;
using System.Runtime.InteropServices;
using System.Security.Permissions;
using Microsoft.SharePoint;
using SPS.MFiles.Common;

namespace SPS.MFiles.Features.SPS.MFiles.Site.Feature
{
    /// <summary>
    /// This class handles events raised during feature activation, deactivation, installation, uninstallation, and upgrade.
    /// </summary>
    /// <remarks>
    /// The GUID attached to this class may be used during packaging and should not be modified.
    /// </remarks>

    [Guid("12462eee-df6a-4678-bc8a-19460563b74d")]
    public class SPSMFilesSiteEventReceiver : SPFeatureReceiver
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
    }
}
