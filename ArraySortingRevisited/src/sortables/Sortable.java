package sortables;

import java.util.List;

/**
 * Created by Nick on 2017-01-03.
 */
public interface Sortable<E> {
    void sort(List<E> list);
}
