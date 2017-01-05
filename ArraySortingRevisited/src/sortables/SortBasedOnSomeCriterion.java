package sortables;

import java.util.List;

/**
 * Created by Nick on 2017-01-03.
 */
public abstract class SortBasedOnSomeCriterion<E> implements Sortable<E> {
    // Dumb selection sort
    @Override
    public void sort(List<E> list) {
        final int len = list.size();
        for (int i = 0; i < len; i++) {
            int index = getFringeIndex(list, i, len);
            if (index != i) {
                swap(list, i, index);
            }
        }
    }

    // An index candidate to swap based on whatever criterion given by isMoreOfAGivenExtreme()
    private int getFringeIndex(List<E> list, int low, int high) {
        int fringeIndex = low;
        for (int j = low + 1; j < high; j++) {
            if (isMoreOfAGivenExtreme(list.get(j), list.get(fringeIndex))) {
                fringeIndex = j;
            }
        }

        return fringeIndex;
    }

    private void swap(List<E> list, int i, int j) {
        E temp = list.get(i);
        list.set(i, list.get(j));
        list.set(j, temp);
    }

    public abstract boolean isMoreOfAGivenExtreme(E candidate, E opponent);
}