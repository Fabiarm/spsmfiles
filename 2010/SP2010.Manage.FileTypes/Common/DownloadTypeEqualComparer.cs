using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SP2010.Manage.FileTypes
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
