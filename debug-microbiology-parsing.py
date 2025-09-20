#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Debug script to understand the microbiology file structure
"""

import re
from typing import List, Dict, Any

def debug_file_structure(file_path: str):
    """Debug the file structure to understand patterns"""
    
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.read()
    
    print(f"📊 Загальний розмір файлу: {len(content)} символів")
    print(f"📊 Кількість рядків: {len(content.splitlines())}")
    
    # Розділяємо на блоки за подвійними переносами рядків
    blocks = re.split(r'\n\s*\n', content)
    print(f"📊 Кількість блоків (розділених \n\n): {len(blocks)}")
    
    # Аналізуємо перші 10 блоків
    print("\n🔍 Аналіз перших 10 блоків:")
    for i, block in enumerate(blocks[:10]):
        block = block.strip()
        if not block:
            continue
            
        lines = [line.strip() for line in block.split('\n') if line.strip()]
        
        print(f"\n--- Блок {i+1} ---")
        print(f"Розмір: {len(block)} символів")
        print(f"Кількість рядків: {len(lines)}")
        print(f"Перші 3 рядки:")
        for j, line in enumerate(lines[:3]):
            print(f"  {j+1}: {line[:80]}...")
        
        # Перевіряємо, чи є опції
        option_lines = []
        for line in lines:
            if re.match(r'^[A-E]', line) or re.match(r'^[А-Е]', line):
                option_lines.append(line)
        
        print(f"Рядки з опціями: {len(option_lines)}")
        if option_lines:
            print("Приклади опцій:")
            for opt in option_lines[:3]:
                print(f"  {opt[:60]}...")

def main():
    input_file = '/Users/bohdanpavliuk/Desktop/бази/Мікробіологія_очищено.txt'
    
    print("🔍 Аналіз структури файлу мікробіології...")
    debug_file_structure(input_file)

if __name__ == "__main__":
    main()