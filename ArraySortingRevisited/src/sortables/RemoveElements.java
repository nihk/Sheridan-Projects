package sortables;

import java.util.List;
import java.util.ListIterator;

/**
 * Created by Nick on 2017-01-03.
 */
public abstract class RemoveElements<E> implements Sortable<E> {
    @Override
    public void sort(List<E> list) {
        final ListIterator<E> listIterator = list.listIterator();
        while (listIterator.hasNext()) {
            final E e = listIterator.next();
            if (isElementToRemove(e)) {
                listIterator.remove();
            }
        }
    }

    public abstract boolean isElementToRemove(E e);
}
