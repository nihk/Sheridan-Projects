import sortables.Sortable;

import java.util.*;

/**
 * Created by Nick on 2017-01-02.
 */
public class Sorter<E> {
    private final List<E> mList;
    private final Set<Sortable<E>> mSortables;

    public Sorter(E[] array) {
        mList = new ArrayList<E>();
        Collections.addAll(mList, array);
        mSortables = new HashSet<>();
    }

    @SafeVarargs
    public final Sorter<E> addSortables(Sortable<E>... sortables) {
        Collections.addAll(mSortables, sortables);

        return this;
    }

    public Sorter<E> sort() {
        for (Sortable<E> sortable : mSortables) {
            sortable.sort(mList);
        }

        return this;
    }

    public void print() {
        final int size = mList.size();
        if (size == 0) {
            return;
        }

        System.out.print(mList.get(0));
        for (int i = 1; i < size; i++) {
            System.out.print(", " + mList.get(i));
        }
        System.out.println();
        System.out.println();
    }
}
