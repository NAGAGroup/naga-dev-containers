import json
import os
import pprint
import subprocess
import shutil
import tomllib


def backup_files():
    if os.path.exists("pixi.toml"):
        if os.path.exists("pixi.toml.bak"):
            os.remove("pixi.toml.bak")
        os.rename("pixi.toml", "pixi.toml.bak")
    if os.path.exists("pixi.lock"):
        if os.path.exists("pixi.lock.bak"):
            os.remove("pixi.lock.bak")
        os.rename("pixi.lock", "pixi.lock.bak")
    if os.path.exists(".pixi"):
        if os.path.exists(".pixi.bak"):
            shutil.rmtree(".pixi.bak")
        os.rename(".pixi", ".pixi.bak")


def restore_files():
    if os.path.exists("pixi.toml"):
        os.remove("pixi.toml")
    if os.path.exists("pixi.lock"):
        os.remove("pixi.lock")
    if os.path.exists(".pixi"):
        shutil.rmtree(".pixi")
    os.rename("pixi.toml.bak", "pixi.toml")
    os.rename("pixi.lock.bak", "pixi.lock")
    os.rename(".pixi.bak", ".pixi")


def update_env(pixi_data):
    conda_packages = pixi_data.get("dependencies", None)
    if conda_packages is not None:
        conda_packages = [pkg_name for pkg_name in conda_packages]
        pixi_add_args = " ".join(conda_packages)
        subprocess.run(f"pixi add {pixi_add_args}", shell=True, check=True)

    pypi_packages = pixi_data.get("pypi-dependencies", None)
    if pypi_packages is not None:
        pypi_packages = []
        for pkg_name, meta in pypi_packages.items():
            if isinstance(meta, str):
                pypi_packages.append(pkg_name)
            else:
                extras = meta.get("extras", None)
                if extras is not None:
                    extras = ",".join(extras)
                    pypi_packages.append(f"{pkg_name}[{extras}]")
                else:
                    pypi_packages.append(pkg_name)
        pypi_packages = " ".join(pypi_packages)
        subprocess.run(f"pixi add --pypi {pypi_packages}", shell=True, check=True)


if __name__ == "__main__":
    # read pixi.toml, up to [dependencies] section
    with open("pixi.toml", "rb") as f:
        pixi_data = tomllib.load(f)

    pprint.pprint(pixi_data)

    with open("pixi.toml", "r") as f:
        pixi_toml = f.read()

    pixi_header = pixi_toml.split("[dependencies]")[0]

    backup_files()

    with open("pixi.toml", "w") as f:
        f.write(pixi_header)

    try:
        update_env(pixi_data)
    except Exception as e:
        restore_files()
        raise e
