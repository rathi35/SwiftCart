#!/usr/bin/env python3
"""
copilot_test.py
Print system uptime in a safe, reliable way.

This file was created as part of a Copilot test. The original Copilot suggestion is likely a small one-liner
using os.popen() or similar; this script replaces that with safer subprocess.run() calls, uses functions,
and adds fallbacks and exception handling for reliability across platforms.
"""

import os
import time
import subprocess
from datetime import timedelta


def format_seconds(sec: float) -> str:
    """Format seconds into a human-readable H:MM:SS or D days, HH:MM:SS string."""
    return str(timedelta(seconds=int(sec)))


def get_uptime_psutil() -> str | None:
    """Try to get uptime via psutil if it's installed.
    Returns a formatted string or None on failure.
    """
    try:
        import psutil
    except Exception:
        return None
    try:
        boot = psutil.boot_time()
        return format_seconds(time.time() - boot)
    except Exception:
        return None


def get_uptime_proc() -> str | None:
    """Try to read /proc/uptime (Linux)."""
    try:
        if os.path.exists('/proc/uptime'):
            with open('/proc/uptime', 'r', encoding='utf-8') as f:
                first = f.readline().split()
                if not first:
                    return None
                uptime_seconds = float(first[0])
                return format_seconds(uptime_seconds)
    except Exception:
        return None


def get_uptime_uptime_cmd() -> str | None:
    """Run the system 'uptime' command as a fallback and return its output.
    We use subprocess.run with a timeout to avoid hanging.
    """
    try:
        # Use a safe argument list; do not use shell=True.
        res = subprocess.run(['uptime'], capture_output=True, text=True, check=True, timeout=5)
        return res.stdout.strip()
    except Exception:
        return None


def get_system_uptime() -> str:
    """Get the system uptime using several strategies. Raises RuntimeError if none work."""
    # 1. psutil (best when available)
    up = get_uptime_psutil()
    if up:
        return up

    # 2. /proc/uptime (Linux)
    up = get_uptime_proc()
    if up:
        return up

    # 3. uptime command (generic fallback)
    up = get_uptime_uptime_cmd()
    if up:
        return up

    raise RuntimeError('Could not determine system uptime on this platform.')


def main() -> None:
    try:
        uptime = get_system_uptime()
        print('System uptime:', uptime)
    except Exception as e:
        # Print a concise error message and exit with non-zero status to indicate failure.
        print('Error getting uptime:', e)
        raise SystemExit(1)


if __name__ == '__main__':
    main()
