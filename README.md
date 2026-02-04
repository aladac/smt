# smt - Show Me Time

[![Ruby](https://github.com/aladac/smt/actions/workflows/main.yml/badge.svg)](https://github.com/aladac/smt/actions/workflows/main.yml)

Too lazy to switch from the terminal to check the time? Same. `smt` displays the current time across multiple timezones in a neat table, right where you already are.

|    | Location   | Time                |
|----|------------|---------------------|
| 🇵🇱 | Warsaw     | 2026-02-04 18:30:00 |
| 🇬🇧 | London     | 2026-02-04 17:30:00 |
| 🇺🇸 | New York   | 2026-02-04 12:30:00 |

## Installation

```
gem install smt
```

## Configuration

Create a `~/.smtrc.yml` file with your timezones:

```yaml
- emoji: "🇵🇱"
  label: Warsaw
  time_zone: Europe/Warsaw
  color: red
- emoji: "🇬🇧"
  label: London
  time_zone: Europe/London
  color: blue
- emoji: "🇺🇸"
  label: New York
  time_zone: America/New_York
  color: green
```

Labels support `strftime` format codes, so you can use dynamic values like `%A` for the day name.

## Usage

```
smt                          # show current time
smt -t "2026-02-04 15:00"   # convert a specific time
smt -f "%H:%M"              # custom time format (default: %Y-%m-%d %H:%M:%S)
smt -l                      # list all available timezones
smt -v                      # show version
```

## License

[MIT](https://opensource.org/licenses/MIT)
