# GitHub Copilot test: system uptime script

This repository contains a small test created as part of an exercise with GitHub Copilot.

## Summary

- File added: `copilot_test.py` — a script to print the system uptime.
- Purpose: observe Copilot's suggestion, accept and then improve the generated code for security and reliability, and commit the result.

## What Copilot suggested (expected)

When asked to create a script to print system uptime, Copilot typically suggests a short Python snippet — often using `os.popen()` or similar to call the `uptime` command and print its output. That suggestion is a quick way to get results but has security and reliability drawbacks (e.g., shell=True usage, no timeouts, no platform fallbacks).

## What I changed and why

Improvements made to the initial suggestion:

- Replaced `os.popen()` (or other shell-based calls) with `subprocess.run()` to avoid shell injection risks and to allow timeouts and error handling.
- Wrapped logic into small functions for clarity and testability:
  - `get_uptime_psutil()` — uses `psutil` if available (most reliable programmatic method).
  - `get_uptime_proc()` — reads `/proc/uptime` on Linux.
  - `get_uptime_uptime_cmd()` — falls back to the system `uptime` command using `subprocess.run()` with a timeout.
  - `get_system_uptime()` — coordinates the above methods and raises a clear error if none work.
- Added exception handling and explicit failure behavior (exit with a non-zero code).
- Formatted uptime in a human-readable form using `datetime.timedelta`.

These changes make the script safer (no shell), more robust (multiple fallbacks), and easier to maintain.

## How to run

1. Make the script executable (optional):

   chmod +x copilot_test.py

2. Run with Python 3:

   python3 copilot_test.py

Expected output example:

  System uptime: 2:15:37

On systems where the `uptime` command outputs a more verbose string, the script will print that entire line as a final fallback.

## Testing

To test the script:

- Run `python3 copilot_test.py`. It should print the uptime or a concise error message.
- If you want the `psutil` path to be exercised, install psutil (`pip install psutil`) and run again.
- On Linux systems, the `/proc/uptime` method will be used if available.

## Notes

- The script aims to be cross-platform where possible, but the most reliable programmatic method is `psutil`.
- If you need machine-readable uptime (e.g., seconds only), modify `format_seconds()` or return raw seconds from one of the helper functions.

