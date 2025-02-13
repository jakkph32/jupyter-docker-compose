# JupitorNotebooks Project

## Running with Docker Compose

### Prerequisites
- Docker
- Docker Compose

### Steps

1. Build and run the Docker containers:
   ```sh
   docker-compose up --build
   ```

2. Access Jupyter Notebook in your web browser at `http://localhost:8888`. Token is `token`.

---

## Notes on Types of Class

## Table of Contents
- [Python Interface Overview](#python-interface-overview)
- [Informal Interfaces](#informal-interfaces)
- [Using Metaclasses](#using-metaclasses)
- [Using Virtual Base Classes](#using-virtual-base-classes)
- [Formal Interfaces](#formal-interfaces)
- [Interfaces in Other Languages](#interfaces-in-other-languages)
  - [Java](#java)
  - [C++](#c)
  - [Go](#go)
- [Conclusion](#conclusion)

---

## Python Interface Overview

At a high level, an interface acts as a **blueprint** for designing classes. Like classes, interfaces define methods. Unlike classes, these methods are **abstract**, meaning they are defined but not implemented. Concrete classes implement these methods to provide functionality.

Python handles interfaces differently than languages like **Java, Go, and C++**, which have a dedicated `interface` keyword. Instead, Python allows interfaces to be implemented using abstract base classes (`ABC`).

---

## Informal Interfaces

Python’s dynamic nature allows for **informal interfaces**, where methods are defined in a base class but not strictly enforced. 

### Example:
```python
class InformalParserInterface:
    def load_data_source(self, path: str, file_name: str) -> str:
        """Load in the file for extracting text."""
        pass

    def extract_text(self, full_file_name: str) -> dict:
        """Extract text from the currently loaded file."""
        pass
```

A concrete class can inherit from this informal interface:

```python
class PdfParser(InformalParserInterface):
    def load_data_source(self, path: str, file_name: str) -> str:
        pass

    def extract_text(self, full_file_path: str) -> dict:
        pass
```

However, Python does not enforce that a subclass must implement all methods of the informal interface.

---

## Using Metaclasses

A **metaclass** can enforce that all required methods are implemented:

```python
class ParserMeta(type):
    def __subclasscheck__(cls, subclass):
        return (hasattr(subclass, 'load_data_source') and 
                callable(subclass.load_data_source) and 
                hasattr(subclass, 'extract_text') and 
                callable(subclass.extract_text))

class UpdatedInformalParserInterface(metaclass=ParserMeta):
    pass
```

Now, checking subclasses with `issubclass()` will correctly determine if a class implements all required methods.

---

## Using Virtual Base Classes

Python allows **virtual base classes** that don't appear in `__mro__` but still provide an interface:

```python
import abc

class PersonMeta(type):
    def __subclasscheck__(cls, subclass):
        return (hasattr(subclass, 'name') and callable(subclass.name) and 
                hasattr(subclass, 'age') and callable(subclass.age))

class Person(metaclass=PersonMeta):
    pass

class Friend:
    def name(self):
        pass

    def age(self):
        pass
```

Now, `issubclass(Friend, Person)` returns `True` even though `Friend` does not explicitly inherit from `Person`.

---

## Formal Interfaces

For a **formal interface**, Python uses `abc.ABC`:

```python
import abc

class FormalParserInterface(abc.ABC):
    @abc.abstractmethod
    def load_data_source(self, path: str, file_name: str):
        pass

    @abc.abstractmethod
    def extract_text(self, full_file_path: str):
        pass
```

If a concrete class fails to implement all abstract methods, it **cannot be instantiated**.

### Example:
```python
class PdfParser(FormalParserInterface):
    def load_data_source(self, path: str, file_name: str):
        pass

    def extract_text(self, full_file_path: str):
        pass
```

This ensures that every subclass correctly implements the required methods.

---

## Interfaces in Other Languages

### Java
Java has a dedicated `interface` keyword:
```java
public interface FileParserInterface {
    void loadDataSource();
    void extractText();
}
```
Concrete class implementing the interface:
```java
public class PdfParser implements FileParserInterface {
    public void loadDataSource() { /* Implementation */ }
    public void extractText() { /* Implementation */ }
}
```

---

### C++
C++ uses **abstract base classes** with `virtual` methods:
```cpp
class FileParserInterface {
public:
    virtual void loadDataSource(std::string path, std::string file_name) = 0;
    virtual void extractText(std::string full_file_name) = 0;
};
```
Concrete implementation:
```cpp
class PdfParser : public FileParserInterface {
public:
    void loadDataSource(std::string path, std::string file_name) override { /* Implementation */ }
    void extractText(std::string full_file_name) override { /* Implementation */ }
};
```

---

### Go
Go uses `interface` but does not have classes:
```go
type FileParserInterface interface {
    loadDataSet(path string, filename string)
    extractText(full_file_path string)
}
```
Concrete struct implementing the interface:
```go
type PdfParser struct {}

func (p PdfParser) loadDataSet(path string, filename string) {
    // Implementation
}

func (p PdfParser) extractText(full_file_path string) {
    // Implementation
}
```

---

## Conclusion

Python provides great flexibility in interface design:
- **Informal interfaces** work well for small projects.
- **Formal interfaces** using `abc.ABC` enforce method implementation.
- **Metaclasses** and **virtual base classes** offer advanced interface mechanisms.
- Python’s approach differs from **Java, C++, and Go**, which have explicit interface keywords.

By implementing interfaces, you can create well-structured, maintainable, and scalable software.
