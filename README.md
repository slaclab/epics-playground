## Prerequisites

Make sure you [have epics installed](https://docs.epics-controls.org/en/latest/getting-started/installation.html) in your dev environment.

## Compile toyIoc

```bash
cd toyIoc
make
```

## Run the service

```bash
cd toyIoc/iocBoot/ioctoyIoc
chmod +x st.cmd
./st.cmd
```

You can get a list of available PVs by running `dbl` cmd in the epics prompt:

```bash
epics> dbl
```

You should get something like this:

```
SPHERE:X1
SPHERE:X2
SPHERE:F
```

## Use the service

Get values of `SPHERE:X1` and `SPHERE:X2`:

```bash
caget SPHERE:X1  # init value: 0
caget SPHERE:X2  # init value: 0
```

Set values to the two variable PVs:

```bash
caput SPHERE:X1 3
caput SPHERE:X2 4
```

Get the observable PV (L2 norm of `SPHERE:X1` and `SPHERE:X2`):

```bash
caget SPHERE:F  # should be 5
```

Now you can use the [sphere_epics Badger env](https://github.com/slaclab/Badger-Plugins/tree/master/environments/sphere_epics) in your dev env :)
