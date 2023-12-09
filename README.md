# Binance Futures Leverage and Margin Type Setter

Welcome to the Binance Futures Leverage and Margin Type Setter! This script allows you to set the leverage and margin type for all futures pairs on Binance via their API. It's designed to be easy to use, efficient, and secure.

## Features

- Sets the leverage for all futures pairs.
- Sets the margin type to isolated for all futures pairs.
- Verifies the set leverage and margin type for each pair.
- Logs all operations for easy debugging and verification.

## Prerequisites

- Bash
- curl
- jq
- openssl

## Installation

1. Clone this repository to your local machine.
2. Navigate to the directory containing the script.
3. Make the script executable by running `chmod +x script.sh`.

## Usage

1. Open the script in a text editor.
2. Replace `your_api_key` and `your_api_secret` with your actual Binance API key and secret.
3. Save and close the file.
4. Run the script by typing `./script.sh` in your terminal.

## Adapting the Script

- **Change Margin Mode to Cross Margin**: In the script, there is a line where the margin type is set to `ISOLATED`. If you want to change the margin mode to cross margin, you just need to replace `ISOLATED` with `CROSS` in this line.

- **Change Leverage**: If you want to set a different leverage, you just need to change the value of the `LEVERAGE` variable in the script. For example, if you want to set the leverage to 10, you would change `LEVERAGE=5` to `LEVERAGE=10`.

Remember to always use caution when changing leverage and margin type, as these can significantly impact your trading risk. Always make sure you understand the implications of these changes before making them.

## Contributing

Contributions are welcome! Please feel free to submit a pull request.

## Disclaimer

This script is provided as-is, and you bear the risk of using it. You should only use the Binance API within their terms of service. Always use caution when trading on Binance and never risk more than you are willing to lose.

## License

This project is licensed under the MIT License.

## Contact

If you have any questions, feel free to reach out!

Happy trading! 🚀
