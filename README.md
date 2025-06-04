# Reubenmiller Iot-tap

## How do I install these formulae?

`brew install reubenmiller/iot-tap/<formula>`

Or `brew tap reubenmiller/iot-tap` and then `brew install <formula>`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "reubenmiller/iot-tap"
brew "<formula>"
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

## Adding a new Formula

When in doubt following the [online docs](https://brew.sh/2020/11/18/homebrew-tap-with-bottles-uploaded-to-github-releases/).

1. Create a new formula

    ```sh
    brew create --tap=reubenmiller/iot-tap https://github.com/reubenmiller/touchie/archive/0.0.3.tar.gz
    ```

2. Checkout a new branch, commit and then push the formular

    ```sh
    git checkout -b touchie
    git commit --message "touchie 0.3.0 (new formula)"
    git push --set-upstream origin touchie
    ```

3. Wait for the PR checks to be successful

4. Add the "pr-label" to the PR, then wait the PR should close automatically and the changes should be merged into main along with a release containing the binaries.
