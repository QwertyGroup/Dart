typedef Compare<T> = int Function(T a, T b);

int sort(int a, int b) => a - b;

void main() {
  assert(sort is Compare<int>); // True!
}

class SortedCollectionBroken {
  Function compare;

  SortedCollectionBroken(int f(Object a, Object b)) {
    compare = f;
  }
}

// Initial, broken implementation.
int sortBroken(Object a, Object b) => 0;

void mainBroken() {
  SortedCollectionBroken coll = SortedCollectionBroken(sortBroken);

  // All we know is that compare is a function,
  // but what type of function?
  assert(coll.compare is Function);
}

typedef Hello = String Function(int, int);

class FuncLib {
  Hello Do(Hello fn) => fn;
}
