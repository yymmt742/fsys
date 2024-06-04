<br />
<div align="center">
<h3 align="center">fsys</h3>
  <p align="center">
    Wrapper module for system control from fortran
  </p>
</div>

[![CI](https://github.com/yymmt742/fsys/actions/workflows/ci.yml/badge.svg)](https://github.com/yymmt742/fsys/actions/workflows/ci.yml)

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

## Getting Started
### Prerequisites

* gcc >= 9.4.0
* gfortran >= 9.4.0
* cmake >= 3.9

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/yymmt742/utf8f
   ```
2. Build fortran library
   ```sh
   mkdir build && cd build
   cmake ..
   make install
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Usage

   ```fortran
      program main
      use fsys
      implicit none
        print*, isatty() ! T if OUTPUT_UNIT is tty.
      end program main
   ```

   The following suboruotines are available.

  | Interface                | Retrun value | Arguments                                   | Description                                                                                                       |
  | ------------------------ | ------------ | ------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
  | function isatty(unit)    | logical      | unit (integer, optional)                    | Returns .true. if unit is TTY. If unit is not INPUT_UNIT, OUTPUT_UNIT, or ERROR_UNIT, .false. is always returned. |
  | subroutine sleep(sec)    |              | sec (real, double precision)                | Sleep the process.                                                                                                |
  | subroutine winsize(x, y) |              | x, y (integer)                              | Get console size.                                                                                                 |


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

YYMMT742 - yymmt@kuchem.kyoto-u.ac.jp

<p align="right">(<a href="#readme-top">back to top</a>)</p>

