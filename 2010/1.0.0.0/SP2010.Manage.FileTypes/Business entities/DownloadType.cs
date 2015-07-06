using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SP2010.Manage.FileTypes
{
    public class DownloadType
    {
        public string Extension { get; set; }
        public int Size { get; set; }
        public bool Active { get; set; }

        public DownloadType(string extension, int size, bool active)
        {
            Extension = extension.ToLower();
            Size = size;
            Active = active;
        }
    }
}
