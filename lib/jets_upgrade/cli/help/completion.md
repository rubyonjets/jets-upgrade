## Examples

    jets-upgrade completion

Prints words for TAB auto-completion.

    jets-upgrade completion
    jets-upgrade completion hello
    jets-upgrade completion hello name

To enable, TAB auto-completion add the following to your profile:

    eval $(jets-upgrade completion_script)

Auto-completion example usage:

    jets-upgrade [TAB]
    jets-upgrade hello [TAB]
    jets-upgrade hello name [TAB]
    jets-upgrade hello name --[TAB]
