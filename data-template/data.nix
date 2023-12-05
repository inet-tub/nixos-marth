{
  # # you can highlight a region containing all lines beginning with (whitespace followed by `#`
  # # and then uncomment it, which should still have the lines with (whitespace and) `# #` still commented.
  # # Then you can change the values as is appropriate.
  #
  # # find out the name of the device you want to install nixos on.
  # # you can do this via `lsblk`.
  # # the most common would be:
  # installation-device = "nvme0n1";
  # # another common one is the following or similar: 
  # # installation-device = "sda";
  #
  # # declare the hostname of the machine
  # hostname = "faub-laptop-zehn";
  #
  # # Find out RAM, and set an appropriate amount.
  # # You can check this with `free.
  # ram = "24G";
  #
}
