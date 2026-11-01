#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""أداة ضغط البيانات tools/compress_json_payloads.py"""

import os
import glob
import gzip
import shutil

def compress_payloads():
    json_files = glob.glob("content/vocabulary/*.json") + glob.glob("content/sentences/*.json")
    output_dir = "content/compressed"
    os.makedirs(output_dir, exist_ok=True)
    
    total_original = 0
    total_compressed = 0
    count = 0
    
    for file_path in json_files:
        filename = os.path.basename(file_path)
        gz_path = os.path.join(output_dir, f"{filename}.gz")
        
        orig_size = os.path.getsize(file_path)
        total_original += orig_size
        
        with open(file_path, "rb") as f_in:
            with gzip.open(gz_path, "wb", compresslevel=9) as f_out:
                shutil.copyfileobj(f_in, f_out)
                
        comp_size = os.path.getsize(gz_path)
        total_compressed += comp_size
        count += 1
        
    ratio = (1.0 - (total_compressed / total_original)) * 100.0 if total_original > 0 else 0
    print(f"✅ تم ضغط {count} ملفاً بنجاح في {output_dir}: من {total_original/1024:.1f}KB إلى {total_compressed/1024:.1f}KB (توفير {ratio:.1f}%).")

if __name__ == "__main__":
    compress_payloads()
