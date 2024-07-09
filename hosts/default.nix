{lib, ...}: {
  laptop = import ./hp-laptop {inherit lib;};
  huawei-grand-laptop = import ./huawei-grand-laptop {inherit lib;};
}
