using SPS.MFiles.BO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SPS.MFiles.Common
{
    class DownloadTypeEqualComparer : IEqualityComparer<DownloadType>
    {
        public bool Equals(DownloadType x, DownloadType y)
        {
            if (x.Extension == y.Extension)
                return true;
            else
                return false;
        }
        public int GetHashCode(DownloadType obj)
        {
            return base.GetHashCode();
        }
    }
}
