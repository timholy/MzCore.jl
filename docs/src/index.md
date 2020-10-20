```@meta
CurrentModule = MzCore
```

# MzCore

MzCore defines traits and utilities for mass spectrometry analyses in Julia.
The primary purpose is to allow algorithms to be written in a manner that is independent of the representation used for specific file formats.

The API is defined below. Individual file format packages should extend these traits to support the data structures used to load the format. `MzXML` provides an example that can be emulated by other formats.

## API reference

```@index
```

### Type-traits

```@docs
mztype
intensitytype
```

### Value-traits

```@docs
limits
```
